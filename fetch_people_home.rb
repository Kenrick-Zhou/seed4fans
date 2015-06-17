require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'

#alert(document.cookie);
cookie = '_pk_id.100001.8cb4=393ca9cb19a66098.1401619313.124.1434505923.1434503655.; _pk_ref.100001.8cb4=%5B%22%22%2C%22%22%2C1434505877%2C%22http%3A%2F%2Fdevelopers.douban.com%2Fwiki%2F%3Ftitle%3Dlabs%22%5D; _pk_ses.100001.8cb4=*; __utma=30149280.1298617937.1418837375.1434502775.1434505878.84; __utmb=30149280.6.10.1434505878; __utmc=30149280; __utmv=30149280.4746; __utmz=30149280.1434444816.82.22.utmcsr=douban.fm|utmccn=(referral)|utmcmd=referral|utmcct=/; _ga=GA1.2.1298617937.1418837375; ap=1; bid="g3KlaOzy3Oo"; ck="NOif"; ct=y; ll="108288"; ps=y; push_doumail_num=38; push_noty_num=0; viewed="6724611_1868862_10945606_20505765_24896848_3781725_1419696_5999447"'

begin
  # Fetch and parse HTML document
  #http://www.douban.com/people/56910458/
  #http://www.douban.com/people/35370642/
  doc = Nokogiri::HTML(open('http://www.douban.com/people/35370642/',
  "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/600.6.3 (KHTML, like Gecko) Version/8.0.6 Safari/600.6.3",
  "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
  "referer" => "http://www.douban.com",
  "Cookie" => cookie
  ))

  # title = doc.xpath('//title')
  # mc = /\((.*)\)/.match(title[0].to_s)
  # puts mc[1] if mc

  doc.css("div#movie h2 a").each do |a|
    str = a.content
    if str.include? "在看"
      mc = /(\d+)/.match(str)
      puts "在看：" + mc[0]
    elsif str.include? "想看"
      mc = /(\d+)/.match(str)
      puts "想看：" + mc[0]
    elsif str.include? "看过"
      mc = /(\d+)/.match(str)
      puts "看过：" + mc[0]
    end
  end

  doc.css("p.rev-link a").each do |a|
    str = a.content
    mc = /(\d+)/.match(str)
    puts "被关注数：" + mc[0]
  end

  doc.css("div#doulist span.pl a").each do |a|
    str = a.content
    mc = /(\d+)/.match(str)
    puts "豆列数：" + mc[0]
  end

  doc.css("div#review h2 span.pl a").each do |a|
    str = a.content
    if str.start_with?("评论")
      mc = /(\d+)/.match(str)
      puts "评论数：" + mc[0]
    end
  end
  
rescue OpenURI::HTTPError => e
  puts "HTTPError|: " + e.to_s
rescue NameError => e
  puts "HTTPError|: " + e.to_s
rescue StandardError => bang
  puts "HTTPError|: " + bang.to_s
  
end

# doc = Nokogiri::HTML(open('http://www.douban.com/people/35370642/',
#
# "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/600.6.3 (KHTML, like Gecko) Version/8.0.6 Safari/600.6.3",
# "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
# "referer" => "http://www.douban.com",
# "Cookies" => '_pk_id.100001.8cb4=393ca9cb19a66098.1401619313.124.1434505923.1434503655.; _pk_ref.100001.8cb4=%5B%22%22%2C%22%22%2C1434505877%2C%22http%3A%2F%2Fdevelopers.douban.com%2Fwiki%2F%3Ftitle%3Dlabs%22%5D; _pk_ses.100001.8cb4=*; __utma=30149280.1298617937.1418837375.1434502775.1434505878.84; __utmb=30149280.6.10.1434505878; __utmc=30149280; __utmv=30149280.4746; __utmz=30149280.1434444816.82.22.utmcsr=douban.fm|utmccn=(referral)|utmcmd=referral|utmcct=/; _ga=GA1.2.1298617937.1418837375; ap=1; bid="g3KlaOzy3Oo"; ck="NOif"; ct=y; ll="108288"; ps=y; push_doumail_num=38; push_noty_num=0; viewed="6724611_1868862_10945606_20505765_24896848_3781725_1419696_5999447"'
# ))
#
# # title = doc.xpath('//title')
# # mc = /\((.*)\)/.match(title[0].to_s)
# # puts mc[1] if mc
#
# doc.css("div#movie h2 a").each do |a|
#   puts a
# end


# puts a[0]
# puts a[1]
# puts a[2]




# ####
# # Search for nodes by css
# doc.css('nav ul.menu li a').each do |link|
#   puts link.content
# end
#
# ####
# # Search for nodes by xpath
# doc.xpath('//h2 | //h3').each do |link|
#   puts link.content
# end
#
# ####
# # Or mix and match.
# doc.search('code.sh', '//h2').each do |link|
#   puts link.content
# end