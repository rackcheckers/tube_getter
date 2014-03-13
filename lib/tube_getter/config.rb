module TubeGetter
  class Config
    include TubeGetter::Utils
    
    cattr_accessor :temp_path
    cattr_accessor :video_path
    
    def self.configure(&block)
      yield self
    end
    
  end
end
