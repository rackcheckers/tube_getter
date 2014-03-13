module TubeGetter
  class Config
    include TubeGetter::Utils
    
    cattr_accessor :base_path
    
    def self.configure(&block)
      yield self
    end
    
  end
end
