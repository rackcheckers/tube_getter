module TubeGetter
  module Crawler
    class Xhamster < Base
  
      def initialize(url)
        super
        @agent.user_agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 5_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B179 Safari/7534.48.3"
      end
  
      def crawl
        uri.subdomain = 'm'
    
        self.add_cookies()
    
        doc = self.get(uri.to_s)
    
        puts "\n" + (doc / 'title').inner_text + "\n\n"
    
        a = doc.at('.noFlash/a.mp4Thumb')
    
        if a
          puts a['href']
      
          puts "\nDownloading to #{target_filename}\n\n"
      
          puts `wget -c -O "#{target_filename}" "#{a['href']}"`
        else
          puts "Sorry, could not find link to MP4 file."
        end
      end
  
      def add_cookies
        self.add_cookie("mobileUse", "0")
        self.add_cookie("lang",      "en")
        self.add_cookie("mobileUse", "Apple")
      end
  
      def add_cookie(key, value)
        cookie = Mechanize::Cookie.new(key, value)
        cookie.domain = ".xhamster.com"
        cookie.path = "/"
        @agent.cookie_jar.add("http://xhamster.com", cookie)
      end
  
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "xhamster"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.+\/movies\/(\d+)\/.*/, "\\1")
      end
  
    end
  end
end