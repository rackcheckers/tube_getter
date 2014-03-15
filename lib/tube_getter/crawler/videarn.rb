module TubeGetter
  module Crawler
    class Videarn < Base
  
      def initialize(url)
        super
        @agent.user_agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 5_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B179 Safari/7534.48.3"
      end
  
      def crawl
        uri = Addressable::URI.parse('http://m.videarn.com')
        uri.path = 'video.php'
        uri.query_values = {id: self.class.get_id_from_url(url)}
    
        doc = self.get(uri.to_s)
    
        puts "\n" + (doc / 'title').inner_text + "\n\n"
    
        video_url = doc.at('video/source')['src']
    
        puts video_url
    
        puts `wget -c -O "#{temp_filename}" "#{video_url}"`
    
        puts `#{TubeGetter::Config.ffmpeg_path} #{TubeGetter::Config.ffmpeg_default_options} -i "#{temp_filename}" -vcodec copy -acodec copy "#{target_filename}"`
    
        if File.exist?(target_filename) && File.size(target_filename) > 0
          `rm "#{temp_filename}"`
        end
    
      end
  
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "videarn"
      end
  
      def self.get_id_from_url(url)
        uri = Addressable::URI.parse(url)
    
        if uri.query_values
          id = uri.query_values['id']
        else
          id = url.gsub(/.*\.com\/.*?\/(\d+)-.*/, "\\1")
        end
    
        return id
      end
  
    end
  end
end