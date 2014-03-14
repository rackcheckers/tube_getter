module TubeGetter
  class Config
    include TubeGetter::Utils
    
    cattr_accessor :temp_path
    cattr_accessor :video_path
    cattr_accessor :ffmpeg_path
    cattr_accessor :ffmpeg_default_options
    cattr_accessor :ffmpeg_video_codec
    cattr_accessor :ffmpeg_audio_codec
    
    def self.configure(&block)
      yield self
    end
    
  end
end
