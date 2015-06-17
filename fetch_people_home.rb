require 'nokogiri'
require 'open-uri'

#alert(document.cookie);
#cookie = '_pk_id.100001.8cb4=393ca9cb19a66098.1401619313.124.1434505923.1434503655.; _pk_ref.100001.8cb4=%5B%22%22%2C%22%22%2C1434505877%2C%22http%3A%2F%2Fdevelopers.douban.com%2Fwiki%2F%3Ftitle%3Dlabs%22%5D; _pk_ses.100001.8cb4=*; __utma=30149280.1298617937.1418837375.1434502775.1434505878.84; __utmb=30149280.6.10.1434505878; __utmc=30149280; __utmv=30149280.4746; __utmz=30149280.1434444816.82.22.utmcsr=douban.fm|utmccn=(referral)|utmcmd=referral|utmcct=/; _ga=GA1.2.1298617937.1418837375; ap=1; bid="g3KlaOzy3Oo"; ck="NOif"; ct=y; ll="108288"; ps=y; push_doumail_num=38; push_noty_num=0; viewed="6724611_1868862_10945606_20505765_24896848_3781725_1419696_5999447"'
cookie = '_ga=GA1.2.1649888158.1378725770; ll="108288"; bid="eI96RKgftzI"; ps=y; __utmt=1; ck="NOif"; push_noty_num=0; push_doumail_num=38; _pk_id.100001.8cb4=080148761df8a042.1400775463.7.1434538829.1434350081.; _pk_ses.100001.8cb4=*; __utma=30149280.1649888158.1378725770.1434356108.1434538641.14; __utmb=30149280.5.10.1434538641; __utmc=30149280; __utmz=30149280.1434356108.13.2.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not%20provided); __utmv=30149280.4746'
start_id = 1000001


  
# loop do 
  begin
    did, uid, name, c_follower, c_m_do, c_m_wish, c_m_collect, c_doulist, c_review, error = nil
    did = start_id
    # Fetch and parse HTML document
    #http://www.douban.com/people/56910458/
    #http://www.douban.com/people/35370642/
    # doc = Nokogiri::HTML(open("http://www.douban.com/people/#{start_id}/",
    doc = Nokogiri::HTML(open("http://www.douban.com/people/35370642/",
    "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/600.6.3 (KHTML, like Gecko) Version/8.0.6 Safari/600.6.3",
    "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    "referer" => "http://www.douban.com",
    "Cookie" => "dbcl2=47460982:F8hiarH1JZY"
    ))

    name = doc.at_css("head title").content.strip
    puts "name：" + name

    uid = doc.at_css("div#profile div.user-info div.pl").content.split(" ")[0]
    puts "uid: " + uid

    doc.css("div#movie h2 a").each do |a|
      str = a.content
      if str.include? "在看"
        mc = /(\d+)/.match(str)
        c_m_do = mc[0]
        puts "在看：" + c_m_do
      elsif str.include? "想看"
        mc = /(\d+)/.match(str)
        c_m_wish = mc[0]
        puts "想看：" + c_m_wish
      elsif str.include? "看过"
        mc = /(\d+)/.match(str)
        c_m_collect = mc[0]
        puts "看过：" + c_m_collect
      end
    end

    doc.css("p.rev-link a").each do |a|
      str = a.content
      mc = /(\d+)/.match(str)
      c_follower = mc[0]
      puts "被关注数：" + c_follower
    end

    doc.css("div#doulist span.pl a").each do |a|
      str = a.content
      mc = /(\d+)/.match(str)
      c_doulist = mc[0]
      puts "豆列数：" + c_doulist
    end

    doc.css("div#review h2 span.pl a").each do |a|
      str = a.content
      if str.start_with?("评论")
        mc = /(\d+)/.match(str)
        c_review = mc[0]
        puts "评论数：" + c_review
      end
    end
    
  rescue OpenURI::HTTPError => e
    puts "HTTPError|: " + e.to_s
  rescue NameError => e
    puts "HTTPError|: " + e.to_s
  rescue StandardError => bang
    puts "HTTPError|: " + bang.to_s
  end
  
  start_id += 1
  sleep 2
# end
