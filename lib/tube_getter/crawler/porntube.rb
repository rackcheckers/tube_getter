module TubeGetter
  module Crawler
    class Porntube < Base
  
      def crawl
        doc = self.get(original_url)
    
        puts "\n" + (doc / 'title').inner_text + "\n\n"
    
        # Find the script that inserts the player object
        player_js = doc.search('script').detect{|s| s.to_s.match(/playerConfigPlaylist/)}.to_s
        media_id  = player_js.gsub(/.*embedPlayer\((\d+), .*\).*/mi, "\\1")
    
        # Find out the largest possible video
        sizes = player_js.gsub(/.*embedPlayer\(\d+,\s+\d+,\s+\[((\d+,?)+)\].*\).*/mi, "\\1")
        largest_size = sizes.split(',').last
    
        # retrieve the JSON that holds the information about the videos
        json_url = "http://tkn.porntube.com/#{media_id}/desktop/240+360+480"
        json = self.post(json_url, {}, {'Origin'=>'http://www.porntube.com', 'Referer'=>'http://www.porntube.com'})
    
        json = JSON.parse(json.body)
    
        video_url = json[largest_size]['token']
    
        wget(video_url, target_filename)
      end
  
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "porntube"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.+_(\d+)(\?.*)?\z/, "\\1")
      end
  
    end
  end
end