module TubeGetter
  module Crawler
    class Drtuber < Base

      def crawl
        # uri.subdomain = 'm'
    
        doc = self.get(uri.to_s)
        
        puts "\n" + (doc / 'title').inner_text + "\n\n"
        
        video_url = doc.at('#hidden_html5_block/video/source')['src']
        
        wget(video_url + '&play', target_filename)
    
        # puts `#{TubeGetter::Config.ffmpeg_path} #{TubeGetter::Config.ffmpeg_default_options} -i "#{temp_filename}" -vcodec copy -acodec copy "#{target_filename}"`
        #
        # if File.exist?(target_filename) && File.size(target_filename) > 0
        #   `rm "#{temp_filename}"`
        # end
    
      end
      
      def title
        @doc ||= self.get()
      end
      
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "drtuber"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.*\/video\/(\d+)\/.*/, "\\1")
      end
  
    end
  end
end