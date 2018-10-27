require 'yaml'

data = YAML.load(File.read('db/seeds/data/artists.yml'))

data.each do |k, row|
  a = Artist.create( {
    id: row['artistid'],
    name: row['artistname'],
  })
end
