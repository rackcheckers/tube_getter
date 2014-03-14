module TubeGetter
  module Crawler
    class Xplay < Base
  
      def initialize
        super
        @agent.user_agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 5_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B179 Safari/7534.48.3"
        @agent.follow_meta_refresh = true
        add_cookies
      end
  
      def crawl(url)
        @url = url
    
        uri = Addressable::URI.parse(url)
    
        begin
          # try to get the mobile version
          uri.path = "/mobile" + uri.path
      
          doc = self.get(uri.to_s)
      
          puts "\n" + (doc / 'title').inner_text + "\n\n"
      
          video_url = doc.at('video#video/source')['src']
      
          puts video_url
      
          puts `wget -c --no-check-certificate -O "#{target_filename}" "#{video_url}"`
        rescue Mechanize::ResponseCodeError
          # no mobile version -> get the flv
      
          doc = self.get(url)
      
          puts "\n" + (doc / 'title').inner_text + "\n\n"
      
          iframe_doc = self.get(doc.at('iframe')['src'])
      
          script = iframe_doc.search('script').detect{|s| s.inner_text.strip.length > 0}
          script = script.inner_text.strip
      
          video_url = script.gsub(/.*url:\s+escape\(['"](http[^'"]+)['"]\).*/im, "\\1")
      
          puts video_url
      
          puts `wget -c --no-check-certificate -O "#{temp_filename}" "#{video_url}"`
      
          puts `#{TubeGetter::Config.ffmpeg_path} -y -i "#{temp_filename}" -vcodec copy -acodec copy "#{target_filename}"`
    
          if File.exist?(target_filename) && File.size(target_filename) > 0
            `rm "#{temp_filename}"`
          end
    
        end
      end
  
      def add_cookies
        self.add_cookie("mobile", "on")
      end
  
      def add_cookie(key, value)
        cookie = Mechanize::Cookie.new(key, value)
        cookie.domain = ".xplay.co"
        cookie.path = "/"
        @agent.cookie_jar.add("http://www.xplay.co", cookie)
      end
  
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "xplay"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.*:.*-(\d+).*/, "\\1")
      end
  
    end
  end
end