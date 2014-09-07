module TubeGetter
  module Crawler
    class YoutubeDlBase < Base

      def crawl
        youtube_dl
      end
      
      def youtube_dl
        progress_regex = /.*\s+(\d+\.\d+)%\s+of\s+.*/
        
        IO.popen("#{self.class.youtube_dl_bin} --newline -v -f best -o \"#{target_filename}\" \"#{original_url}\" 2>&1", "r") do |pipe|
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
      
      def self.youtube_dl_bin
        File.expand_path('../../../../bin/youtube-dl', __FILE__)
      end
      
      def self.youtube_dl_id(url)
        `#{youtube_dl_bin} --get-id #{url}`.strip
      end
      
      def self.get_id_from_url(url)
        youtube_dl_id(url)
      end
      
    end 
  end
end