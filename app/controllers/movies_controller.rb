require 'nokogiri'
require 'open-uri'
require 'mechanize'

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
    cookie = params[:cookie]
    start_id = params[:start_at].to_i
    end_id = params[:end_at].to_i
    error_seq = 0
    Thread.new do
      start_id.upto(end_id) do |mid|
        begin
          uri = "http://movie.douban.com/subject/#{mid}/"
          puts "→→→ start to fetch id:#{mid}"
          begin
            agent = Mechanize.new
            page = agent.get(uri, [], URI("http://www.douban.com"), {
                                    "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/600.6.3 (KHTML, like Gecko) Version/8.0.6 Safari/600.6.3",
                                    "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
                                    "Cookie" => "dbcl2=47460982:#{cookie}"
                                })
          rescue Mechanize::ResponseCodeError => e
            puts  "MechanizeError|: #{e.to_s}"
            next
          end
          doc = Nokogiri::HTML.parse(page.body, nil, 'utf-8')
          @movie = Movie.new


          puts '########################################'
          puts '## 各种名称、年代'
          title, cn_title, original_title, pubyear = nil
          tmp = doc.at_css('div#comments-section h2 i').content
          puts cn_title = tmp[0, tmp.index('的短评')]
          puts title = doc.at_css('div#content h1 span').content
          puts original_title = title[cn_title.length + 1 .. -1]
          puts pubyear = doc.at_css('div#content h1 span.year').content[1..-2] unless doc.at_css('div#content h1 span.year').nil?
          @movie.title = title
          @movie.cn_title = cn_title
          @movie.original_title = original_title
          @movie.pubyear = pubyear
          @movie.save



          puts '########################################'
          puts '## 海报、评分、类型（电影/TV）、片长（单集片长 if tv）、IMDb、简介'
          poster_url, poster_id, rating, subtype, duration, imdb_id, summary, e_duration, e_count = nil
          puts '==============================='
          puts info_text = doc.at_css('div#info').inner_text
          puts '==============================='

          puts poster_url = doc.at_css('div#mainpic a img').attr('src')
          puts poster_id = poster_url.split('/')[-1].split('.')[0]

          puts rating = doc.at_css('div#interest_sectl p.rating_self strong.rating_num').content

          subtype = 'movie'
          doc.css('div#info span.pl').each do |span|
            subtype = 'tv' if span.content.include? '集数'
            subtype = 'tv' if span.content.include? '单集片长'
          end
          puts subtype

          if subtype == 'tv'
            puts e_duration = /(\d+)/.match(/(\s\d+分钟)/.match(info_text)[0])[0]
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
          @movie.poster_url = poster_url
          @movie.poster_id = poster_id
          @movie.rating = rating
          @movie.subtype = subtype
          @movie.duration = duration
          @movie.imdb_id = imdb_id
          @movie.summary = summary
          @movie.e_duration = e_duration
          @movie.e_count = e_count
          @movie.save


          # puts '****************************************'
          # puts '** 又名'
          # aka = nil
          #
          # i = info_text.index('又名:')
          # puts language = info_text[i+4, info_text.index("\n", i)-i].split('/').collect{|x| x.strip!} if i
          # # j = info_text.index('IMDb链接:')
          # # if i
          # #   if j
          # #     puts info_text[i+4, j-i-12].split('/').collect{|x| x.strip!}
          # #   else
          # #     puts aka = info_text[i+4, info_text.length-i-15].split('/').collect{|x| x.strip!}
          # #   end
          # # end
          #
          #
          # puts '========================================'
          # puts '== 明星 及 明星在该电影中的角色（导演/编辑/主演）'
          # celebrity, movie_celebrity = nil
          #
          # doc.css('div#info > span').each do |span0|
          #   if span0.css('span').size == 2 && span0.css('span')[0].content =~ /导演|编剧|主演/
          #     puts span0.css('span')[0].content + ":"
          #     span0.css('span')[1].css('a').each do |a|
          #       if a.attr('href').start_with?("/celebrity/")
          #         puts a.content + '(' + a.attr('href').split('/')[2] + ')'
          #       else
          #         puts a.content
          #       end
          #     end
          #   end
          # end
          #
          #
          # puts '========================================'
          # puts '== 类型'
          # type, movie_type = nil
          #
          # doc.css('div#info span').each do |span|
          #   puts span.content if span.attr('property') == 'v:genre'
          # end
          #
          #
          # puts '========================================'
          # puts '== 国家/地区、语言'
          # country, movie_country, language, movie = nil
          #
          # i = info_text.index('制片国家/地区:')
          # j = info_text.index('语言:')
          #
          # puts country = info_text[i+9, info_text.index("\n", i)-i].split('/').collect{|x| x.strip!} if i
          # puts language = info_text[j+4, info_text.index("\n", j)-j].split('/').collect{|x| x.strip!} if j
          #
          # # if i
          # #   if j
          # #     puts info_text[i+9, j-i-17].split('/').collect{|x| x.strip!}
          # #   else
          # #     puts country = info_text[i+4, info_text.length-i-15].split('/').collect{|x| x.strip!}
          # #   end
          # #   k = subtype == 'tv' ? info_text.index('首播:') : info_text.index('上映日期:')
          # #   puts '⬆️国家⬆️  ⬇️语言⬇️'
          # #   # puts j
          # #   # puts k = info_text.index("\n", j)
          # #   puts language = info_text[j+4, info_text.index("\n", j)-j].split('/').collect{|x| x.strip!}
          # #   # if k
          # #   #   puts info_text[j+4, k-j-12].split(' / ')
          # #   # else
          # #   #   puts language = info_text[j+4, info_text.length-k-15].split(' / ').collect{|x| x.strip!}
          # #   # end
          # # end
          #
          #
          # puts '========================================'
          # puts '== 常用标签'
          # tag, movie_tag = nil
          #
          # doc.css('div.tags-body a').each do |a|
          #   puts tag = a.content
          # end
          #
          #
          # puts '****************************************'
          # puts '** 照片'
          # photo = nil
          #
          # doc.css('div#related-pic img').each do |img|
          #   if img.attr('alt') == '图片'
          #     puts /public\/(.*).jpg/.match(img.attr('src'))[1]
          #     puts /\/\/(.*)\.douban\.com/.match(img.attr('src'))[1]
          #   end
          # end
          #
          #
          # puts '****************************************'
          # puts '** 获奖简况'
          # award = nil
          #
          # doc.css('div.mod ul.award').each do |ul|
          #   puts ul.css('li')[0].content
          #   puts ul.css('li')[1].content
          #   puts '---------'
          # end
          #
          #
          # puts '****************************************'
          # puts '** 推荐（喜欢这部电影的人也喜欢）'
          # recommendation = nil
          #
          # doc.css('div#recommendations dl').each do |dl|
          #   puts /subject\/(\d*)/.match(dl.at_css('dt a').attr('href'))[1]
          #   mc = /public\/(.*).jpg|mpic\/(.*).jpg/.match(dl.at_css('dt a img').attr('src'))
          #   puts mc[1].nil? ? mc[2] : mc[1]
          #   # puts /public\/(.*).jpg|mpic\/(.*).jpg/.match(dl.at_css('dt a img').attr('src'))[1]
          #   puts /\/\/(.*)\.douban\.com/.match(dl.at_css('dt a img').attr('src'))[1]
          #   puts dl.at_css('dd a').content
          #   puts '----------'
          # end
          #
          #
          # puts '****************************************'
          # puts '** 豆列（以下豆列推荐）'
          # doulist = nil
          #
          # doc.css('div#subject-doulist li').each do |li|
          #   puts li.at_css('a').content
          #   puts li.at_css('a').attr('href').split('/')[-1]
          #   puts li.at_css('span').content[1..-2]
          # end
          #
          #
          # puts '****************************************'
          # puts '** 热门评论'
          # hot_comment = nil
          #
          # doc.css('div#hot-comments div.comment-item div.comment').each do |div|
          #   puts div.at_css('h3 span.comment-info a').attr('href').split('/')[-1]
          #   puts div.at_css('h3 span.comment-info a').content
          #   #很差、较差、还行、推荐、力荐
          #   puts div.at_css('h3 span.comment-info span.rating').attr('title') unless div.at_css('h3 span.comment-info span.rating').nil?
          #   # puts div.at_css('h3 span.comment-info span.rating').attr('title')#很差、较差、还行、推荐、力荐
          #   puts div.css('h3 span.comment-info span')[-1].content.strip
          #   puts div.at_css('p').content.strip
          #   puts '-------'
          # end
          #
          #
          # puts '****************************************'
          # puts '** 最新评论'
          # new_comment = nil
          #
          # if page.links_with(:text => '最新').size != 0
          #   page = page.links_with(:text => '最新')[-1].click
          #   doc = Nokogiri::HTML.parse(page.body, nil, 'utf-8')
          #
          #   # doc.css('div#new-comments div.comment-item div.comment').each do |div|
          #   doc.css('div#comments div.comment-item div.comment').each do |div|
          #     puts div.at_css('h3 span.comment-info a').attr('href').split('/')[-1]
          #     puts div.at_css('h3 span.comment-info a').content
          #     #很差、较差、还行、推荐、力荐
          #     puts div.at_css('h3 span.comment-info span.rating').attr('title') unless div.at_css('h3 span.comment-info span.rating').nil?
          #     # puts div.at_css('h3 span.comment-info span.rating').attr('title')#很差、较差、还行、推荐、力荐
          #     puts div.css('h3 span.comment-info span')[-1].content.strip
          #     puts div.at_css('p').content.strip
          #     puts '-------'
          #   end
          # end


        rescue OpenURI::HTTPError => e
          error_seq += 1 if e.to_s.include?("redirection forbidden")
          error = "HTTPError|: " + e.to_s
          puts error
        rescue NameError => e
          error_seq += 1 if e.to_s.include?("redirection forbidden")
          error = "NameError|: " + e.to_s
          puts error
        rescue StandardError => bang
          error_seq += 1 if bang.to_s.include?("redirection forbidden")
          error = "StandardError|: " + bang.to_s
          puts error
        ensure
          puts "——————oOo——————"
          sleep 2
          break if error_seq > 5
        end
      end
    end
    puts "fetch movie thread done!"
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
end
