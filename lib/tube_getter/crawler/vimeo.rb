module TubeGetter
  module Crawler
    class Vimeo < Base
      
      def crawl
        video_id = original_url.gsub(/.*\/(\d+).*/, "\\1")
        
        info_url = "http://player.vimeo.com/video/#{video_id}/config"
        
        doc = self.get(info_url)
        
        json = JSON.parse(doc.body)
        
        video_url = json['request']['files']['h264']['hd']['url']
        
        puts video_url
        
        wget(video_url, target_filename)
      end
  
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "vimeo"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.*\/(\d+).*/, "\\1")
      end
  
    end
  end
end