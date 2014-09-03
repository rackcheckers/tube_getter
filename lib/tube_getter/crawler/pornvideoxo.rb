module TubeGetter
  module Crawler
    class Pornvideoxo < Base
  
      def crawl
        doc = self.get(original_url)
    
        puts "\n" + (doc / 'title').inner_text + "\n\n"
        
        video_uri = Addressable::URI.parse(doc.at('link[rel="video_src"]')['href'])
        
        file_doc = self.post('http://pornvideoxo.com/i.php', {token: video_uri.query_hash['c']})
        
        video_url = file_doc.at('file').inner_text
        
        puts video_url
        
        wget(video_url, temp_filename)
    
        puts `#{TubeGetter::Config.ffmpeg_path} #{TubeGetter::Config.ffmpeg_default_options} -i "#{temp_filename}" -vcodec #{TubeGetter::Config.ffmpeg_video_codec} -acodec #{TubeGetter::Config.ffmpeg_audio_codec} "#{target_filename}"`
    
        if File.exist?(target_filename) && File.size(target_filename) > 0
          `rm "#{temp_filename}"`
        end
    
      end
  
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "pornvideoxo"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.*-(\d+)\.html.*/, "\\1")
      end
  
    end
  end
end