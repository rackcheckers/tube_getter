module TubeGetter
  module Crawler
    class Youtube < YoutubeDlBase

      # ------------------------------------------------------------------------------------------------------------

      def self.slug
        "youtube"
      end
      
      def self.needs_conversion?
        false
      end
      
    end
  end
end
