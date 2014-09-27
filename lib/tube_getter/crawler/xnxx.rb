module TubeGetter
  module Crawler
    class Xnxx < YoutubeDlBase

      # ------------------------------------------------------------------------------------------------------------

      def self.slug
        "xnxx"
      end
      
      def self.needs_conversion?
        true
      end
      
    end
  end
end
