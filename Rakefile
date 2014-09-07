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
    c.temp_path  = "/Users/rc/Sites/tube_getter/files/temp"
    c.video_path = "/Users/rc/Sites/tube_getter/files/videos"
    
    c.ffmpeg_path = "/opt/local/bin/ffmpeg"
    c.ffmpeg_default_options = "-y"
    c.ffmpeg_video_codec = "h264"
    c.ffmpeg_audio_codec = "aac -strict -2"
  end
  
  crawler_class = TubeGetter::CrawlerFactory.get_crawler_from_url(args[:url])
  crawler = crawler_class.new(args[:url])
  
  crawler.crawl
  
  while crawler.download_progress < 100 && !crawler.done do
    puts crawler.download_progress
    sleep 1
  end
end