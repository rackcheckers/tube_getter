module TubeGetter
  module Crawler
    class Nuvid < Base
  
      def initialize(url)
        super
        @agent.user_agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 5_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B179 Safari/7534.48.3"
      end
  
      def crawl
        uri.subdomain = 'm'
    
        doc = self.get(uri.to_s)
    
        puts "\n" + (doc / 'title').inner_text + "\n\n"
    
        video_url = uri.normalized_host + doc.search('a').detect{|a| a.inner_text.match(/play mp4/i)}['href']
    
        puts video_url
    
        wget(video_url, target_filename)
      end
  
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "nuvid"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.*\/video\/(\d+)\/.*/, "\\1")
      end
      
      def self.needs_conversion?
        true
      end
      
    end
  end
end