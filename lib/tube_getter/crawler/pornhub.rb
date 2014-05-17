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
    
        video_url = doc.at('a#videoLinkPlaceholder')['href']
    
        puts `wget -c -O "#{target_filename}" "#{video_url}"`
      end
      
      def add_cookies
        self.add_cookie("use_html5_player", "1")
        self.add_cookie("age_verified", "1")
      end
  
      def add_cookie(key, value)
        cookie = Mechanize::Cookie.new(key, value)
        cookie.domain = ".pornhub.com"
        cookie.path = "/"
        @agent.cookie_jar.add("http://www.pornhub.com", cookie)
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