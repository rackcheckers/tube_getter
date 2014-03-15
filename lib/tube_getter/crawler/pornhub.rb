module TubeGetter
  module Crawler
    class Pornhub < Base
  
      def initialize(url)
        super
        @agent.user_agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 5_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B179 Safari/7534.48.3"
      end
  
      def crawl
        doc = self.get(original_url)
    
        puts "\n" + (doc / 'title').inner_text + "\n\n"
    
        video_url = doc.at('.video_hub/.thumb/div/a#video_link')['href']
    
        puts `wget -c -O "#{temp_filename}" "#{video_url}"`
    
        puts `#{TubeGetter::Config.ffmpeg_path} #{TubeGetter::Config.ffmpeg_default_options} -i "#{temp_filename}" -vcodec copy -acodec copy "#{target_filename}"`
    
        if File.exist?(target_filename) && File.size(target_filename) > 0
          `rm "#{temp_filename}"`
        end
    
      end
  
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "pornhub"
      end
  
      def self.get_id_from_url(url)
        uri = Addressable::URI.parse url
        uri.query_values['viewkey'].strip
      end
  
    end
  end
end