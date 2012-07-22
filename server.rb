Bundler.require

set :views, 'source'

get '/hn.json' do
  body = Nokogiri::HTML(Curl::Easy.perform("http://news.ycombinator.com").body_str)
  table = body.css("body >center >table >tr:nth-child(3) >td >table")
  table.css(">tr").each_slice(3).select { |x| x.length == 3 }.map { |title, score, _| {
    title: title.css("td.title a").text,
    link: title.css("td.title a").attr('href').value,
    domain: title.css(".comhead").text.gsub(/[\(\) ]/,''),
    score: score.css(".subtext >span").text.to_i,
    user: score.css("a:first-of-type").text,
    age: score.css('td:nth-child(2)').first.children[3].text.gsub(/\|/,'').strip,
    comments: score.css("a:last-of-type").text.to_i,
    comments_link: score.css("a:last-of-type").attr('href').value
  }}.to_json
end

get '/' do
  haml :index
end

get '/style.css' do
  content_type 'text/css'
  Sass.compile(File.read(File.dirname(__FILE__) + "/source/style.sass"), syntax: :sass)
end

get '/app.js' do
  coffee :app
end
