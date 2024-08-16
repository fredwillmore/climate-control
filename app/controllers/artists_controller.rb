class ArtistsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { 
        render json: Artist.all 
      }
    end
  end

  def show
    @artist = Artist.find(params[:id])
    
    if spotify_artist = ApiInteraction.new(@artist).get_spotify_data()
      @artist_description = "#{@artist.name} is an artist on label X"
      @artist_albums = spotify_artist.albums.map { |album| "#{album.name} - #{album.label}"}
      @genres_description = "Genres: #{spotify_artist.genres.join(', ')}"
      @related_artists_description = "Related artists: #{spotify_artist.related_artists.map(&:name).join(', ')}"
    end
  
    respond_to do |format|
      format.html
      format.json { 
        render json: @artist
      }
    end
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

  def get_spotify_data(artist)
    if !spotify_data = cache_read(artist.id)
      if spotify_data = RSpotify::Artist.search(artist.name).first
        cache_write(artist.id, spotify_data)
      end
    end
    spotify_data
  end
  
end
