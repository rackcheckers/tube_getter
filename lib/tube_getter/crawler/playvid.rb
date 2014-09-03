module TubeGetter
  module Crawler
    class Playvid < Base
      
      def crawl
        doc = self.get(original_url)
        
        puts "\n" + (doc / 'title').inner_text + "\n\n"
        
        # Get the embed and attach the flashvars to a fake URI,
        # so we can parse it with Addressable
        embed = doc.at('embed#video_player')
        fake_uri = Addressable::URI.parse("http://fake.com?" + embed['flashvars'])
        
        video_urls = fake_uri.query_values.select{|k, v| k.match(/^video_vars\[video_urls\]\[\d+p\]$/) && v!=""}
        video_url = video_urls.sort_by{|k, v| k}.last[1]
        
        wget(video_url, target_filename)
        
#         puts `#{TubeGetter::Config.ffmpeg_path} #{TubeGetter::Config.ffmpeg_default_options} -i "#{temp_filename}" -vcodec copy -acodec copy "#{target_filename}"`
#         
#         if File.exist?(target_filename) && File.size(target_filename) > 0
#           `rm "#{temp_filename}"`
#         end
      end
      
      # ------------------------------------------------------------------------------------------------------------
      
      def self.slug
        "playvid"
      end
  
      def self.get_id_from_url(url)
        uri = Addressable::URI.parse url
        if uri.query_values && uri.query_values['v']
          uri.query_values['v']
        else
          url.gsub(/.*\/watch\/([0-9a-z\-]+)/i, "\\1")
        end
      end
      
    end
  end
end