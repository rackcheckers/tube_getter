module TubeGetter
  module Crawler
    class Tnaflix < YoutubeDlBase

      # ------------------------------------------------------------------------------------------------------------

      def self.slug
        "tnaflix"
      end
      
      def self.needs_conversion?
        false
      end
      
    end
  end
end
