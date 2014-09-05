module TubeGetter
  module Crawler
    class Nonktube < Base
      
      def crawl
        video_id = original_url.gsub(/.*\/video\/(\d+).*/, "\\1")
        
        info_url = "http://www.nonktube.com/media/nuevo/econfig.php?key=#{video_id}"
        
        doc = self.get(info_url)
        
        video_url = doc.at('config/file').text
        
        puts video_url
        
        wget(video_url, target_filename)
      end
  
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "nonktube"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.*\/video\/(\d+).*/, "\\1")
      end
  
    end
  end
end