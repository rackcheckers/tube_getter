module TubeGetter
  module Crawler
    class Xvideos < Base
  
      def crawl(url)
        @url = url
    
        doc = self.get(url)
    
        puts "\n" + (doc / 'title').inner_text + "\n\n"
    
        embed = doc.at('#player/#flash-player-embed')
    
        fake_uri = Addressable::URI.parse("http://fake.com?" + embed['flashvars'])
    
        video_url = fake_uri.query_values['flv_url']
    
        puts `wget -c -O "#{temp_filename}" "#{video_url}"`
    
        puts `#{TubeGetter::Config.ffmpeg_path} -y -i "#{temp_filename}" -vcodec h264 -strict -2 -acodec aac "#{target_filename}"`
    
        if File.exist?(target_filename) && File.size(target_filename) > 0
          `rm "#{temp_filename}"`
        end
    
      end
  
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "xvideos"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.+\/video(\d+)\/.*/, "\\1")
      end
  
    end
  end
end