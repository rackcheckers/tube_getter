module TubeGetter
  module Crawler
    class Xhamster < Base
      
      def crawl
        doc = self.get(original_url)
    
        puts "\n" + (doc / 'title').inner_text + "\n\n"
    
        a = doc.at('object/video/div.noFlash/a.mp4Thumb')
    
        wget(a['href'], target_filename)
      end
      
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "xhamster"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.+\/movies\/(\d+)\/.*/, "\\1")
      end
      
      def self.needs_conversion?
        false
      end
      
    end
  end
end