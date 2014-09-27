module TubeGetter
  module Crawler
    class Cliphunter < YoutubeDlBase

      # ------------------------------------------------------------------------------------------------------------

      def self.slug
        "cliphunter"
      end
      
      def self.needs_conversion?
        false
      end
      
    end
  end
end
