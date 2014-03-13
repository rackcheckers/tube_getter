module TubeGetter
  class CrawlerFactory
  
    def self.get_crawler_from_url(url)
      begin
        uri  = Addressable::URI.parse(url)
        name = uri.host.gsub(/\A(www|m)\./i, "").split(".").first
        name.downcase!
        name[0] = name[0].upcase
        
        class_name = "TubeGetter::Crawler::#{name}"
        
        return eval("#{class_name}")
        
      rescue NameError => e
        puts "Class '#{class_name}' not found..."
      end
    end
  
  end
end