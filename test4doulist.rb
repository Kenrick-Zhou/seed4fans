require 'nokogiri'
require 'open-uri'

# Fetch and parse HTML document
# doc = Nokogiri::HTML(open('http://www.douban.com/people/3554459/doulists/all',
# "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/600.6.3 (KHTML, like Gecko) Version/8.0.6 Safari/600.6.3",
# "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
# "referer" => "http://www.douban.com"
# ))
#
# title = doc.xpath('//title')
# mc = /\((.*)\)/.match(title[0].to_s)
# puts mc[1] if mc

for i in 1..10
  begin
    
  rescue StandardError => bang
    puts 999
  ensure
    break if i == 5
    puts i
  end
end

puts "out"

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