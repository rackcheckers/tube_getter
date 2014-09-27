module TubeGetter
  module Crawler
    class Beeg < YoutubeDlBase

      # ------------------------------------------------------------------------------------------------------------

      def self.slug
        "beeg"
      end
      
      def self.needs_conversion?
        false
      end
      
    end
  end
end
