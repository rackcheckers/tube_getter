module TubeGetter
  module Crawler
    class Porntube < YoutubeDlBase

      # ------------------------------------------------------------------------------------------------------------

      def self.slug
        "porntube"
      end
      
      def self.needs_conversion?
        false
      end
      
    end
  end
end
