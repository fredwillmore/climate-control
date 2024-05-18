require 'yaml'

data = YAML.load_file(
  'db/seeds/data/playlist_items.yml', 
  permitted_classes: [Date]
)
data.each do |k, playlist_item|
  PlaylistItem.create(
    track: Track.find( playlist_item['trackid'] ),
    playlist: Playlist.find_by( date: playlist_item['playlistdate'] ),
    position: playlist_item['playlistorder']
  )
end