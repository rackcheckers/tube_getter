module TubeGetter
  module Crawler
    class Xvideos < Base
  
      def crawl
        doc = self.get(original_url)
    
        puts "\n" + (doc / 'title').inner_text + "\n\n"
    
        embed = doc.at('#player/#flash-player-embed')
    
        fake_uri = Addressable::URI.parse("http://fake.com?" + embed['flashvars'])
    
        video_url = fake_uri.query_values['flv_url']
    
        wget(video_url, target_filename)
      end
  
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "xvideos"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.+\/video(\d+)\/.*/, "\\1")
      end
      
      def self.needs_conversion?
        true
      end
      
    end
  end
end