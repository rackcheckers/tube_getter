module TubeGetter
  module Crawler
    class Base
      
      attr_accessor :original_url, :uri, :doc, :download_progress
      
      def initialize(url)
        @agent = Mechanize.new
        @agent.user_agent_alias = 'Windows IE 7'
        @original_url = url
        @uri = Addressable::URI.parse(url)
      end
      
      def get(*args)
        @agent.get(*args)
      end
  
      def post(*args)
        @agent.post(*args)
      end
  
      def filename
        self.class.filename(original_url)
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
      
      def title
        raise "Title method is not implemented! Please override this method."
      end
      
      def save_and_open(doc)
        text = (doc.respond_to?(:body) ? doc.body : doc)
        
        filename = "/tmp/#{SecureRandom.uuid}.html"
        File.open(filename, "w") do |f|
          f.write(text)
        end
        
        `open #{filename}`
      end
      
      def wget(url, filename)
        progress_regex = /.* \.{10} \.{10} \.{10} \.{10} \.{10} (\d+)%.*/
        
        IO.popen("wget -c -O \"#{filename}\" \"#{url}\" 2>&1", "r") do |pipe|
          pipe.each do |line|
            if line.match(progress_regex)
              @download_progress = line.gsub(progress_regex, "\\1").to_i
              sleep 1
            end
          end
        end
        
        @download_progress = 100 if @download_progress > 0
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