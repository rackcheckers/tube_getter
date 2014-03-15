module TubeGetter
  module Crawler
    class Redtube < Base
  
      def crawl
        doc = self.get(original_url)
    
        puts "\n" + (doc / 'title').inner_text + "\n\n"
    
        lines = (doc / '.videoPlayer/script').inner_html.gsub(/\r/, '').split(/\n/).map(&:strip)
        source_line = lines.detect{|l| l.match(/.*\<source.*/)}
    
        video_url = source_line.gsub(/.*src=["']([^"']+)["'].*/, "\\1")
    
        puts `wget -c -O "#{temp_filename}" "#{video_url}"`
    
        puts `#{TubeGetter::Config.ffmpeg_path} #{TubeGetter::Config.ffmpeg_default_options} -i "#{temp_filename}" -vcodec copy -acodec copy "#{target_filename}"`
    
        if File.exist?(target_filename) && File.size(target_filename) > 0
          `rm "#{temp_filename}"`
        end
    
      end
  
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "redtube"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.+\/(\d+)(#.*)?/, "\\1")
      end
  
    end
  end
end