class ApiInteraction
  attr_accessor :object

  def initialize(object)
    @object = object
  end

  def get_spotify_data()
    if !spotify_data = cache_read(object.id)
      # TODO: inject the dependency on object type
      if spotify_data = RSpotify::Artist.search(object.name).first
        cache_write(object.id, spotify_data)
      end
    end
    spotify_data
  end

  private 

  def cache_key(id)
    "artist_#{id}"
  end

  def cache_write(id, object)
    Rails.cache.write(cache_key(id), object)
  end

  def cache_read(id)
    Rails.cache.read(cache_key(id))
  end
end