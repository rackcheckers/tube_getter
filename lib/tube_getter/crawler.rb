Dir.glob(File.expand_path('../crawler/*.rb', __FILE__)).each do |file|
  require file
end

module TubeGetter
  module Crawler
    
  end
end