module TubeGetter
  module Crawler
    class Youporn < Base
      
      def crawl
        self.add_cookies()
        
        doc = self.get(original_url)
        
        puts "\n" + (doc / 'title').inner_text + "\n\n"
        
        video_url = doc.body.gsub(/.*var html5src = '(.*?)'.*/mi, "\\1")
        video_url = video_url.gsub(/\&amp;/, "&")
        
        puts video_url
        
        wget(video_url, target_filename)
      end
      
      def add_cookies
        self.add_cookie("age_verified", "1")
      end
  
      def add_cookie(key, value)
        cookie = Mechanize::Cookie.new(key, value)
        cookie.domain = ".youporn.com"
        cookie.path = "/"
        @agent.cookie_jar.add("http://youporn.com", cookie)
      end
      
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "youporn"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.*\/watch\/(\d+)\/.*/, "\\1")
      end
      
      def self.needs_conversion?
        false
      end
      
    end
  end
end