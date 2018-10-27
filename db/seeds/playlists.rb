require 'yaml'

data = YAML.load(File.read('db/seeds/data/playlist_items.yml'))
dates = data.map do |k, row|
  row['playlistdate']
end.uniq
dates.each do |date|
  Playlist.create date: date  
end