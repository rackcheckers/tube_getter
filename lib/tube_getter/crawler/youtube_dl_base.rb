module TubeGetter
  module Crawler
    class YoutubeDlBase < Base

      def crawl
        youtube_dl
      end
      
      def youtube_dl
        puts `#{self.class.youtube_dl_bin} -v -f best -o \"#{target_filename}\" \"#{original_url}\"`
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