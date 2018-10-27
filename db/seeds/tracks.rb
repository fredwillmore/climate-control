require 'yaml'

data = YAML.load(File.read('db/seeds/data/tracks.yml'))
data.each do |k, row|
  Track.create( {
    id: row['trackid'],
    name: row['trackname'],
    comments: row['comments'],
    artist: Artist.find(row['artistid'])
  })
end
