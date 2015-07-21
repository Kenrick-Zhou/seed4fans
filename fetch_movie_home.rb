require 'nokogiri'
require 'open-uri'
require 'mechanize'


begin
  # Fetch and parse HTML document
  #末代皇帝#  http://movie.douban.com/subject/1293172/
  #机器人9号# http://movie.douban.com/subject/1764796/
  #水浇园丁#  http://movie.douban.com/subject/1867744/
  #冰火5#     http://movie.douban.com/subject/25826612/
  #编辑部的故事#  http://movie.douban.com/subject/2154390/
  #开卷8分钟# http://movie.douban.com/subject/26292731/
  #风云再起#  http://movie.douban.com/subject/26269551/
  uri = "http://movie.douban.com/subject/1867744/"
  
  agent = Mechanize.new
  page = agent.get(uri, {
    "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/600.6.3 (KHTML, like Gecko) Version/8.0.6 Safari/600.6.3",
    "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    "referer" => "http://www.douban.com",
    "Cookie" => "dbcl2=47460982:uGEqI7WKrho"
  })
  doc = Nokogiri::HTML.parse(page.body, nil, 'utf-8')
  
  # doc = Nokogiri::HTML(open(uri,
  # #doc = Nokogiri::HTML(open("http://www.douban.com/people/croath/",
  #                           "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/600.6.3 (KHTML, like Gecko) Version/8.0.6 Safari/600.6.3",
  #                           "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
  #                           "referer" => "http://www.douban.com",
  #                           "Cookie" => "dbcl2=47460982:uGEqI7WKrho"
  #                      ))
                       
  puts '########################################'
  puts '## 各种名称、年代'
  title, cn_title, original_title, pubyear = nil
  
  tmp = doc.at_css('div#content div.article div.related-info h2').content
  puts cn_title = tmp[0, tmp.index('的剧情简介')]
  
  tmp = doc.css('div#content h1 span')
  title = tmp[0].content
  puts original_title = title[cn_title.length + 1 .. -1]
  puts pubyear = tmp[1].content[1, 4]
  
  
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
  
  
  puts '****************************************'
  puts '** 又名'
  aka = nil
  
  i = info_text.index('又名:')
  puts language = info_text[i+4, info_text.index("\n", i)-i].split('/').collect{|x| x.strip!} if i
  # j = info_text.index('IMDb链接:')
  # if i
  #   if j
  #     puts info_text[i+4, j-i-12].split('/').collect{|x| x.strip!}
  #   else
  #     puts aka = info_text[i+4, info_text.length-i-15].split('/').collect{|x| x.strip!}
  #   end
  # end
  
  
  puts '========================================'
  puts '== 明星 及 明星在该电影中的角色（导演/编辑/主演）'
  celebrity, movie_celebrity = nil
  
  doc.css('div#info > span').each do |span0|
    if span0.css('span').size == 2 && span0.css('span')[0].content =~ /导演|编剧|主演/
      puts span0.css('span')[0].content + ":"
      span0.css('span')[1].css('a').each do |a|
        if a.attr('href').start_with?("/celebrity/")
          puts a.content + '(' + a.attr('href').split('/')[2] + ')'
        else
          puts a.content
        end
      end
    end
  end
  
  
  puts '========================================'
  puts '== 类型'
  type, movie_type = nil
  
  doc.css('div#info span').each do |span|
    puts span.content if span.attr('property') == 'v:genre'
  end
  
  
  puts '========================================'
  puts '== 国家/地区、语言'
  country, movie_country, language, movie = nil
  
  i = info_text.index('制片国家/地区:')
  j = info_text.index('语言:')
  
  puts country = info_text[i+9, info_text.index("\n", i)-i].split('/').collect{|x| x.strip!} if i
  puts language = info_text[j+4, info_text.index("\n", j)-j].split('/').collect{|x| x.strip!} if j
  
  # if i
  #   if j
  #     puts info_text[i+9, j-i-17].split('/').collect{|x| x.strip!}
  #   else
  #     puts country = info_text[i+4, info_text.length-i-15].split('/').collect{|x| x.strip!}
  #   end
  #   k = subtype == 'tv' ? info_text.index('首播:') : info_text.index('上映日期:')
  #   puts '⬆️国家⬆️  ⬇️语言⬇️'
  #   # puts j
  #   # puts k = info_text.index("\n", j)
  #   puts language = info_text[j+4, info_text.index("\n", j)-j].split('/').collect{|x| x.strip!}
  #   # if k
  #   #   puts info_text[j+4, k-j-12].split(' / ')
  #   # else
  #   #   puts language = info_text[j+4, info_text.length-k-15].split(' / ').collect{|x| x.strip!}
  #   # end
  # end
  
  
  puts '========================================'
  puts '== 常用标签'
  tag, movie_tag = nil
  
  doc.css('div.tags-body a').each do |a|
    puts tag = a.content
  end
  
  
  puts '****************************************'
  puts '** 照片'
  photo = nil
  
  doc.css('div#related-pic img').each do |img|
    if img.attr('alt') == '图片'
      puts /public\/(.*).jpg/.match(img.attr('src'))[1]
      puts /\/\/(.*)\.douban\.com/.match(img.attr('src'))[1]
    end
  end
  
  
  puts '****************************************'
  puts '** 获奖简况'
  award = nil
  
  doc.css('div.mod ul.award').each do |ul|
    puts ul.css('li')[0].content
    puts ul.css('li')[1].content
    puts '---------'
  end
  
  
  puts '****************************************'
  puts '** 推荐（喜欢这部电影的人也喜欢）'
  recommendation = nil
  
  doc.css('div#recommendations dl').each do |dl|
    puts /subject\/(\d*)/.match(dl.at_css('dt a').attr('href'))[1]
    mc = /public\/(.*).jpg|mpic\/(.*).jpg/.match(dl.at_css('dt a img').attr('src'))
    puts mc[1].nil? ? mc[2] : mc[1]
    # puts /public\/(.*).jpg|mpic\/(.*).jpg/.match(dl.at_css('dt a img').attr('src'))[1]
    puts /\/\/(.*)\.douban\.com/.match(dl.at_css('dt a img').attr('src'))[1]
    puts dl.at_css('dd a').content
    puts '----------'
  end
  
  
  puts '****************************************'
  puts '** 豆列（以下豆列推荐）'
  doulist = nil
  
  doc.css('div#subject-doulist li').each do |li|
    puts li.at_css('a').content
    puts li.at_css('a').attr('href').split('/')[-1]
    puts li.at_css('span').content[1..-2]
  end
  
  
  puts '****************************************'
  puts '** 热门评论'
  hot_comment = nil

  doc.css('div#hot-comments div.comment-item div.comment').each do |div|
    puts div.at_css('h3 span.comment-info a').attr('href').split('/')[-1]
    puts div.at_css('h3 span.comment-info a').content
    #很差、较差、还行、推荐、力荐
    puts div.at_css('h3 span.comment-info span.rating').attr('title') unless div.at_css('h3 span.comment-info span.rating').nil?
    # puts div.at_css('h3 span.comment-info span.rating').attr('title')#很差、较差、还行、推荐、力荐
    puts div.css('h3 span.comment-info span')[-1].content.strip
    puts div.at_css('p').content.strip
    puts '-------'
  end
  
  
  puts '****************************************'
  puts '** 最新评论'
  new_comment = nil

  page = page.links.find { |l| l.text == '最新' }.click
  # puts page.body
  doc = Nokogiri::HTML.parse(page.body, nil, 'utf-8')
  
  # doc.css('div#new-comments div.comment-item div.comment').each do |div|
  doc.css('div#comments div.comment-item div.comment').each do |div|
    puts div.at_css('h3 span.comment-info a').attr('href').split('/')[-1]
    puts div.at_css('h3 span.comment-info a').content
    #很差、较差、还行、推荐、力荐
    puts div.at_css('h3 span.comment-info span.rating').attr('title') unless div.at_css('h3 span.comment-info span.rating').nil?
    # puts div.at_css('h3 span.comment-info span.rating').attr('title')#很差、较差、还行、推荐、力荐
    puts div.css('h3 span.comment-info span')[-1].content.strip
    puts div.at_css('p').content.strip
    puts '-------'
  end
  
  
  
  
  
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
end
