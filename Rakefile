require "bundler/gem_tasks"

task :console do
  require 'irb'
  require 'irb/completion'
  require 'tube_getter' # You know what to do.
  ARGV.clear
  IRB.start
end

desc "Gets a video file via URL"
task :get, :url do |t, args|
  require 'tube_getter'
  
  TubeGetter::Config.configure do |c|
    c.base_path = "/Users/rc/Sites/tube_getter/tube_getter.bak"
  end
  
  crawler_class = TubeGetter::CrawlerFactory.get_crawler_from_url(args[:url])
  crawler = crawler_class.new
  
  crawler.crawl(args[:url])
end