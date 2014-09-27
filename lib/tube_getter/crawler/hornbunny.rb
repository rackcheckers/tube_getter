module TubeGetter
  module Crawler
    class Hornbunny < YoutubeDlBase

      # ------------------------------------------------------------------------------------------------------------

      def self.slug
        "hornbunny"
      end
      
      def self.needs_conversion?
        false
      end
      
    end
  end
end
