module TubeGetter
  module Crawler
    class Youjizz < YoutubeDlBase

      # ------------------------------------------------------------------------------------------------------------

      def self.slug
        "youjizz"
      end
      
      def self.needs_conversion?
        false
      end
      
    end
  end
end
