require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'rest-client'
require 'json'

class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    # @movies = Movie.all
    @movies = Movie.order('id desc').page(params[:page]).per(params[:per])
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end


  def fetch
    Celebrity.create_with(name: 'nobody').find_or_create_by(id: 0)
    cookie = params[:cookie]
    start_id = params[:start_at].to_i
    end_id = params[:end_at].to_i
    error_seq = 0
    Thread.new do
      start_id.upto(end_id) do |mid|
        movie, title, cn_title, original_title, pubyear = nil
        poster_url, poster_id, m_rating, subtype, duration, imdb_id, summary, e_duration, e_count = nil
        begin
          uri = "http://movie.douban.com/subject/#{mid}/"
          puts "→→→ start to fetch id:#{mid}"
          begin
            agent = Mechanize.new
            page = agent.get(uri, [], URI("http://www.douban.com"), {
                                    "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/600.6.3 (KHTML, like Gecko) Version/8.0.6 Safari/600.6.3",
                                    "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
                                    "Cookie" => "dbcl2=#{cookie}"
                                })
          rescue Mechanize::ResponseCodeError => e
            error_seq += 1 if e.to_s.include?("403 =>")
            puts  "MechanizeError|: #{e.to_s}"
            next
          end
          doc = Nokogiri::HTML.parse(page.body, nil, 'utf-8')

          puts '########################################'
          puts '## 各种名称、年代'
          tmp = doc.at_css('div#comments-section h2 i').content
          puts cn_title = tmp[0, tmp.index('的短评')]
          puts title = doc.at_css('div#content h1 span').content
          puts original_title = title[cn_title.length + 1 .. -1]
          puts pubyear = doc.at_css('div#content h1 span.year').content[1..-2] unless doc.at_css('div#content h1 span.year').nil?
          movie = Movie.create_with(title: title, cn_title: cn_title, original_title: original_title, pubyear: pubyear).find_or_create_by(id: mid)


          puts '########################################'
          puts '## 海报、评分、类型（电影/TV）、片长（单集片长 if tv）、IMDb、简介'
          puts '==============================='
          puts info_text = doc.at_css('div#info').inner_text
          puts '==============================='

          puts poster_url = doc.at_css('div#mainpic a img').attr('src')
          puts poster_id = poster_url.split('/')[-1].split('.')[0]
          puts m_rating = doc.at_css('div#interest_sectl p.rating_self strong.rating_num').content

          subtype = 'movie'
          doc.css('div#info span.pl').each do |span|
            subtype = 'tv' if span.content.include? '集数'
            subtype = 'tv' if span.content.include? '单集片长'
          end
          puts subtype

          if subtype == 'tv'
            unless /(\s\d+分钟)/.match(info_text).nil?
              puts e_duration = /(\d+)/.match(/(\s\d+分钟)/.match(info_text)[0])[0]
            end
            i = info_text.index('集数')
            # j = info_text.index('单集片长')
            puts e_count = info_text[i+4,info_text.index("\n", i)-i].strip if i #and j
          else
            doc.css('div#info span').each do |span|
              puts duration = span.attr('content') if span.attr('property') == 'v:runtime'
            end
          end

          doc.css('div#info a').each do |a|
            puts imdb_id = a.content if a.content.start_with?("tt")
          end

          doc.css('div#link-report span').each do |span|
            if span.attr('property') == 'v:summary'
              summary = ""
              span.inner_html.split('<br>').each do |p|
                summary = summary << p.strip << '<br>'
              end
              puts summary = summary[0..-5]
            end
          end


          puts '****************************************'
          puts '** 又名'
          i = info_text.index('又名:')
          akas = info_text[i+4, info_text.index("\n", i)-i].split('/').collect{|x| x.strip!} if i
          if akas
            akas.each do |item|
              puts "又名：#{item}"
              Aka.create(movie_id: mid, aka: item)
            end
          end


          puts '========================================'
          puts '== 明星 及 明星在该电影中的角色（导演/编辑/主演）'
          doc.css('div#info > span').each do |span|
            if span.css('span').size == 2 && span.css('span')[0].content =~ /导演|编剧|主演/
              role = span.css('span')[0].content
              puts role + ":"
              span.css('span')[1].css('a').each do |a|
                name = a.content
                if a.attr('href').start_with?("/celebrity/")
                  celebrity_id = a.attr('href').split('/')[2]
                  puts "#{name}(#{celebrity_id})"
                  celebrity = Celebrity.create_with(name: name).find_or_create_by(id: celebrity_id)
                  MovieCelebrity.create(movie_id: mid, celebrity_id: celebrity_id, name: name, role: role)
                else
                  puts name
                  MovieCelebrity.create(movie_id: mid, celebrity_id: 0, name: name, role: role)
                end
              end
            end
          end


          puts '========================================'
          puts '== 类型'
          doc.css('div#info span').each do |span|
            puts type = span.content if span.attr('property') == 'v:genre'
            type = Type.find_or_create_by(name: type)
            MovieType.create(movie_id: mid, type_id: type.id, name: type.id)
          end


          puts '========================================'
          puts '== 国家/地区、语言'
          i = info_text.index('制片国家/地区:')
          info_text[i+9, info_text.index("\n", i)-i].split('/').collect{|x| x.strip!}.each do |country|
            puts country
            country = Country.find_or_create_by(name: country)
            MovieCountry.create(movie_id: mid, country_id: country.id, name: country.name)
          end if info_text.index('制片国家/地区:')

          j = info_text.index('语言:')
          info_text[j+4, info_text.index("\n", j)-j].split('/').collect{|x| x.strip!}.each do |language|
            puts language
            language = Language.find_or_create_by(name: language)
            MovieLanguage.create(movie_id: mid, language_id: language.id, name: language.name)
          end if info_text.index('语言:')


          puts '========================================'
          puts '== 常用标签'
          doc.css('div.tags-body a').each do |a|
            puts tag = a.content
            tag = Tag.find_or_create_by(name: tag)
            MovieTag.create(movie_id: mid, tag_id: tag.id, name: tag.name)
          end


          puts '****************************************'
          puts '** 照片'
          doc.css('div#related-pic img').each do |img|
            if img.attr('alt') == '图片'
              puts pid = /public\/(.*).jpg/.match(img.attr('src'))[1]
              puts cdn = /\/\/(.*)\.douban\.com/.match(img.attr('src'))[1]
              Photo.create(movie_id: mid, pid: pid, cdn: cdn)
            end
          end


          puts '****************************************'
          puts '** 获奖简况'
          doc.css('div.mod ul.award').each do |ul|
            puts name = ul.css('li')[0].content
            puts sub = ul.css('li')[1].content
            Award.create(movie_id: mid, name: name, sub: sub)
            puts '---------'
          end


          puts '****************************************'
          puts '** 推荐（喜欢这部电影的人也喜欢）'
          doc.css('div#recommendations dl').each do |dl|
            puts rcmd_id = /subject\/(\d*)/.match(dl.at_css('dt a').attr('href'))[1]
            src = dl.at_css('dt a img').attr('src')
            puts rcmd_poster_id = src.split('/')[-1].split('.')[0]
            puts rcmd_poster_cdn = /\/\/(.*)\.douban\.com/.match(src)[1]
            puts rcmd_name = dl.at_css('dd a').content
            Recommendation.create(movie_id: mid, rcmd_id: rcmd_id, rcmd_name: rcmd_name, rcmd_poster_id: rcmd_poster_id, rcmd_poster_cdn: rcmd_poster_cdn)
            puts '----------'
          end



          puts '****************************************'
          puts '** 豆列（以下豆列推荐）'
          doc.css('div#subject-doulist li').each do |li|
            puts name = li.at_css('a').content
            puts dlist_id = li.at_css('a').attr('href').split('/')[-1]
            puts uname = li.at_css('span').content[1..-2]
            Doulist.create(movie_id: mid, name: name, dlist_id: dlist_id, uname: uname)
          end


          puts '****************************************'
          puts '** 热门评论'
          doc.css('div#hot-comments div.comment-item div.comment').each do |div|
            puts did = div.at_css('h3 span.comment-info a').attr('href').split('/')[-1]
            puts name = div.at_css('h3 span.comment-info a').content
            #很差、较差、还行、推荐、力荐
            rating = nil
            puts rating = div.at_css('h3 span.comment-info span.rating').attr('title') unless div.at_css('h3 span.comment-info span.rating').nil?
            # puts div.at_css('h3 span.comment-info span.rating').attr('title')#很差、较差、还行、推荐、力荐
            puts pubdate = div.css('h3 span.comment-info span')[-1].content.strip
            puts comment = div.at_css('p').content.strip
            HotComment.create(movie_id: mid, did: did, name: name, rating: rating, pubdate: pubdate, comment: comment)
            puts '-------'
          end


          puts '****************************************'
          puts '** 最新评论'
          if page.links_with(:text => '最新').size != 0
            page = page.links_with(:text => '最新')[-1].click
            doc = Nokogiri::HTML.parse(page.body, nil, 'utf-8')

            # doc.css('div#new-comments div.comment-item div.comment').each do |div|
            doc.css('div#comments div.comment-item div.comment').each do |div|
              puts did = div.at_css('h3 span.comment-info a').attr('href').split('/')[-1]
              puts name = div.at_css('h3 span.comment-info a').content
              #很差、较差、还行、推荐、力荐
              rating = nil
              puts rating = div.at_css('h3 span.comment-info span.rating').attr('title') unless div.at_css('h3 span.comment-info span.rating').nil?
              # puts div.at_css('h3 span.comment-info span.rating').attr('title')#很差、较差、还行、推荐、力荐
              puts pubdate = div.css('h3 span.comment-info span')[-1].content.strip
              puts comment = div.at_css('p').content.strip
              NewComment.create(movie_id: mid, did: did, name: name, rating: rating, pubdate: pubdate, comment: comment)
              puts '-------'
            end
          end


        rescue OpenURI::HTTPError => e
          error_seq += 1 if e.to_s.include?("redirection forbidden") || e.to_s.include?("403")
          error = "HTTPError|: " + e.to_s
          puts error
        rescue NameError => e
          error_seq += 1 if e.to_s.include?("redirection forbidden") || e.to_s.include?("403")
          error = "NameError|: " + e.to_s
          puts error
        rescue StandardError => bang
          error_seq += 1 if bang.to_s.include?("redirection forbidden") || e.to_s.include?("403")
          error = "StandardError|: " + bang.to_s
          puts error
        ensure
          movie.update(
              poster_url: poster_url,
              poster_id: poster_id,
              rating: m_rating,
              subtype: subtype,
              duration: duration,
              imdb_id: imdb_id,
              summary: summary,
              e_duration: e_duration,
              e_count: e_count
          ) unless movie.nil?
          puts "——————oOo——————"
          sleep mid % 2 + 1
          if error_seq > 5
            send_warning
            break
          end
        end
      end
      puts "fetch movie thread done!"
      puts Rails.configuration.x.sendcloud.api_user
    end
  end


  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :cn_title, :original_title, :rating, :poster_url, :poster_id, :subtype, :pubyear, :duration, :imdb_id, :summary, :e_count, :e_duration)
    end

    def send_warning
      conf =  Rails.application.config_for(:send_cloud)
      ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
      ip = ip.ip_address if ip
      vars = JSON.dump({"to" => [conf['to']], "sub" => { "%server_num%" => [ip]} })
      response = RestClient.post "http://sendcloud.sohu.com/webapi/mail.send_template.json",
                                 :api_user => conf['api_user'], # 使用api_user和api_key进行验证
                                 :api_key => conf['api_key'],
                                 :from => conf['from'], # 发信人，用正确邮件地址替代
                                 :fromname => 'Seed4Fans',
                                 :substitution_vars => vars,
                                 :template_invoke_name => 'seed4fans_403',
                                 :subject => '服务异常'

      puts ip
      puts response.code
      puts response.to_str
    end
end
