module TubeGetter
  module Crawler
    class Base
      
      def initialize
        @agent = Mechanize.new
        @agent.user_agent_alias = 'Windows IE 7'
      end
  
      def get(*args)
        @agent.get(*args)
      end
  
      def post(*args)
        @agent.post(*args)
      end
  
      def filename
        self.class.filename(@url)
      end
  
      def target_filename
        File.join TubeGetter::Config.video_path, filename
      end
  
      def temp_filename
        File.join TubeGetter::Config.temp_path, filename
      end
      
      def crawl(*args)
        raise "Crawl method is not implemented! Please override this method."
      end
      
      # ------------------------------------------------------------------------------------------------------------
      
      def self.needs_conversion?
        raise "needs_conversion? method is not implemented! Please override this method."
      end
      
      def self.filename(url)
        "#{slug} - #{get_id_from_url(url)}.mp4"
      end
  
      def self.slug
        raise "Slug method not implemented! Please override this method."
      end
  
      def self.get_id_from_url(url)
        raise "get_id_from_url method not implemented! Please override this method."
      end
  
    end
  end
end