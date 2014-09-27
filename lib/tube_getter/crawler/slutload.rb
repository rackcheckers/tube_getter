module TubeGetter
  module Crawler
    class Slutload < YoutubeDlBase

      # ------------------------------------------------------------------------------------------------------------

      def self.slug
        "slutload"
      end
      
      def self.needs_conversion?
        false
      end
      
    end
  end
end
