module TubeGetter
  module Crawler
    class Videarn < Base
      
      def crawl
        uri.query_values = {id: self.class.get_id_from_url(original_url)}
    
        doc = self.get(uri.to_s)
    
        puts "\n" + (doc / 'title').inner_text + "\n\n"
        
        video_url = doc.at('a#player')['href']
        
        puts video_url
        
        wget(video_url, target_filename)
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
      
      def self.needs_conversion?
        false
      end
      
    end
  end
end