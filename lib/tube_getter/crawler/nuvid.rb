module TubeGetter
  module Crawler
    class Nuvid < Base
  
      def initialize
        super
        @agent.user_agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 5_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B179 Safari/7534.48.3"
      end
  
      def crawl(url)
        @url = url
    
        uri = Addressable::URI.parse(url)
        uri.subdomain = 'm'
    
        doc = self.get(uri.to_s)
    
        puts "\n" + (doc / 'title').inner_text + "\n\n"
    
        video_url = uri.normalized_host + doc.search('a').detect{|a| a.inner_text.match(/play mp4/i)}['href']
    
        puts video_url
    
        puts `wget -c -O "#{temp_filename}" "#{video_url}"`
    
        puts `ffmpeg -y -i "#{temp_filename}" -vcodec copy -acodec copy "#{target_filename}"`
    
        if File.exist?(target_filename) && File.size(target_filename) > 0
          `rm "#{temp_filename}"`
        end
    
      end
  
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "nuvid"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.*\/video\/(\d+)\/.*/, "\\1")
      end
  
    end
  end
end