require 'yaml'
require 'date'

data = YAML.load_file(
  'db/seeds/data/playlist_items.yml', 
  permitted_classes: [Date]
)
dates = data.map do |k, row|
  row['playlistdate']
end.uniq
dates.each do |date|
  Playlist.create date: date  
end