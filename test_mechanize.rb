require 'mechanize'

agent = Mechanize.new
page = agent.get('http://movie.douban.com/subject/1764796/')
puts page.title

page.links.each do |link|
  puts link.text
end

page = agent.page.links.find { |l| l.text == '全片播放' }.click



# link = page.link_with(text: '全片播放')
# page = link.click
# link = page.link_with(text: '最新')
# page = link.click
#
# puts page.content.strip