require 'yaml'

data = YAML.load(File.read('db/seeds/data/tracks.yml'))
data.each do |k, row|
  Track.where(
    id: row['trackid'],
  ).first_or_create( {
    name: row['trackname'],
    comments: row['comments'],
    artist: Artist.find(row['artistid'])
  })
end
