# not functional

# class Cliphunter < Crawler
#   
#   def initialize(url)
#     super
#     @agent.user_agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 5_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B179 Safari/7534.48.3"
#   end
#   
#   def crawl
#     id = url.gsub(/.*\/w\/(\d+)\/.*/, "\\1")
#     
#     @filename = "cliphunter - " + id + ".mp4"
#     
#     # fetch from the tablet subdomain
#     uri.subdomain = 'tablet'
#     
#     # get the doc, just for the cookies
#     self.get(uri.to_s)
#     
#     # set the uri to require json
#     uri.query_values = (uri.query_values || {}).merge({format: 'json'})
#     puts uri.to_s
#     
#     # now get the json
#     doc = self.get(uri.to_s)
#     
#     puts doc.body.to_s
#     
#     puts "\n" + (doc / 'title').inner_text + "\n\n"
#     
#     video_url = doc.at('video#player')['src']
#     
#     puts video_url
#     
#     puts `wget -c -O "#{temp_filename}" "#{video_url}"`
#     
#     puts `#{TubeGetter::Config.ffmpeg_path} #{TubeGetter::Config.ffmpeg_default_options} -i "#{temp_filename}" -vcodec copy -acodec copy "#{target_filename}"`
#     
#     if File.exist?(target_filename) && File.size(target_filename) > 0
#       `rm "#{temp_filename}"`
#     end
#     
#   end
#   
# end
