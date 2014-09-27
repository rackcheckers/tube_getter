module TubeGetter
  module Crawler
    class Fapdu < Base
      
      def crawl
        doc = self.get(@original_url)
    
        video_container = doc.at('#video-container')
    
        # FAPDU is an Aggregator, different crawlers may apply
    
        if video_container.at('iframe') && video_container.at('iframe')['src'].match(/^http.*?xhamster\.com\/.*/)
          puts "xHamster"
      
          xhamster_id = video_container.at('iframe')['src'].gsub(/.*video=(\d+).*/, "\\1")
          
          Xhamster.new("http://www.xhamster.com/movies/#{xhamster_id}/bogus.html").crawl
      
        elsif video_container.at('iframe') && video_container.at('iframe')['src'].match(/^http.*?drtuber\.com\/.*/)
          puts "DrTuber"
      
          drtuber_id = video_container.at('iframe')['src'].gsub(/.*embed\/(\d+).*/, "\\1")
          
          Drtuber.new("http://www.drtuber.com/video/#{drtuber_id}/").crawl
      
        elsif video_container.at('object/embed') && video_container.at('object/embed')['src'].match(/^http.*?redtube\.com\/.*/)
          puts "Redtube"
      
          redtube_id = video_container.at('object/embed')['src'].gsub(/.*id=(\d+).*/, "\\1")
          
          Redtube.new("http://www.redtube.com/#{redtube_id}").crawl
      
        elsif video_container.at('iframe') && video_container.at('iframe')['src'].match(/^http.*?pornhub\.com\/.*/)
          puts "Pornhub"
      
          pornhub_id = video_container.at('iframe')['src'].gsub(/.*embed\/(\d+).*/, "\\1")
          
          Pornhub.new("http://www.pornhub.com/view_video.php?viewkey=#{pornhub_id}").crawl
    
        elsif video_container.at('iframe') && video_container.at('iframe')['src'].match(/^http.*?youporn\.com\/.*/)
          puts "Youporn"
      
          youporn_id = video_container.at('iframe')['src'].gsub(/.*embed\/(\d+).*/, "\\1")
          
          Youporn.new("http://www.youporn.com/watch/#{youporn_id}/").crawl
        elsif video_container.at('iframe') && video_container.at('iframe')['src'].match(/^http.*?youjizz\.com\/.*/)
          puts "Youporn"
      
          youporn_id = video_container.at('iframe')['src'].gsub(/.*embed\/(\d+).*/, "\\1")
          
          Youporn.new("http://www.youporn.com/watch/#{youporn_id}/").crawl
        elsif video_container.at('#faptv')
          puts "Fapdu"
      
          script = video_container.at('script').inner_text.strip
      
          original_url = script.gsub(/.*"file"\s*?:\s*?"([^\"]+)".*/mi, "\\1")
          
          puts original_url
      
          wget(original_url, target_filename)
        else
          puts "Sorry - unhandled source"
          puts "\n\n#{video_container.to_s}\n\n"
        end
      end
  
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "fapdu"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.*\/v\/([^?]+)\?.*/, "\\1")
      end
  
    end
  end
end