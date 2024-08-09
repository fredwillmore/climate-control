require 'yaml'

data = YAML.load_file(
  'db/seeds/data/playlist_items.yml', 
  permitted_classes: [Date]
)
data.each do |k, playlist_item|
  track = Track.find( playlist_item['trackid'] )
  playlist = Playlist.find_by( date: playlist_item['playlistdate'] )

  PlaylistItem.where(
    track: track,
    playlist: playlist,
  ).first_or_create(
    track: track,
    playlist: playlist,
    position: playlist_item['playlistorder']
  )
end