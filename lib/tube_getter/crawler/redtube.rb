module TubeGetter
  module Crawler
    class Redtube < Base
  
      def crawl
        doc = self.get(original_url)
    
        puts "\n" + (doc / 'title').inner_text + "\n\n"
        
        param = doc.at('#redtube_flv_player/noscript/object/param[name="FlashVars"]')
        fake_uri = Addressable::URI.parse("http://fake.com?" + param['value'])
    
        video_url = fake_uri.query_values['video_url']
    
        wget(video_url, target_filename)
      end
  
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "redtube"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.+\/(\d+)(#.*)?/, "\\1")
      end
      
      def self.needs_conversion?
        true
      end
      
    end
  end
end