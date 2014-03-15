module TubeGetter
  module Crawler
    class Xvideos < Base
  
      def crawl
        doc = self.get(original_url)
    
        puts "\n" + (doc / 'title').inner_text + "\n\n"
    
        embed = doc.at('#player/#flash-player-embed')
    
        fake_uri = Addressable::URI.parse("http://fake.com?" + embed['flashvars'])
    
        video_url = fake_uri.query_values['flv_url']
    
        puts `wget -c -O "#{temp_filename}" "#{video_url}"`
    
        puts `#{TubeGetter::Config.ffmpeg_path} #{TubeGetter::Config.ffmpeg_default_options} -i "#{temp_filename}" -vcodec #{TubeGetter::Config.ffmpeg_video_codec} -acodec #{TubeGetter::Config.ffmpeg_audio_codec} "#{target_filename}"`
    
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