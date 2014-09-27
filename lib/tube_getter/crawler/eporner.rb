module TubeGetter
  module Crawler
    class Eporner < Base
  
      def crawl
        doc = self.get(original_url)
    
        puts "\n" + (doc / 'title').inner_text + "\n\n"
    
        script = doc.at('#moviexxx/script')
        
        js_url = "http://www.eporner.com" + script['src']
        
        js_doc = self.get(js_url)
        
        puts "---"
        
        urls = []
        js_doc.body.gsub(/file:\s+\"(.*?\.mp4)\"/im) do
          urls << $~.to_s.gsub(/.*\"(.*)\"/, "\\1")
        end
        urls.sort
        
        video_url = urls.first
        
        puts video_url
        
        wget(video_url, target_filename)
      end
  
      # ------------------------------------------------------------------------------------------------------------
  
      def self.slug
        "eporner"
      end
  
      def self.get_id_from_url(url)
        url.gsub(/.+\/hd\-porn\/(\d+)\/.*/, "\\1")
      end
      
      def self.needs_conversion?
        false
      end
      
    end
  end
end