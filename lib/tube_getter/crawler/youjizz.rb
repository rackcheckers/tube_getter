module TubeGetter
  module Crawler
    class Youjizz < Base
      
      def crawl
        doc = self.get(original_url)
        
        puts "\n" + (doc / 'title').inner_text + "\n\n"
        
        iframe_el = doc.at('td/iframe')
        
        iframe_url = iframe_el['src']
        
        iframe_doc = self.get(iframe_url)
        
        video_url = iframe_doc.body.gsub(/.*"file",encodeURIComponent\("([^"]+)"\).*/im, "\\1")
        
        puts video_url
        
        wget(video_url, temp_filename)
        
        puts `#{TubeGetter::Config.ffmpeg_path} #{TubeGetter::Config.ffmpeg_default_options} -i "#{temp_filename}" -vcodec copy -acodec copy "#{target_filename}"`
        
        if File.exist?(target_filename) && File.size(target_filename) > 0
          `rm "#{temp_filename}"`
        end
        
      end
      
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "youjizz"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.*:.*-(\d+)\.html.*/, "\\1")
      end
      
    end
  end
end