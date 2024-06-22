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
    
    if spotify_artist = RSpotify::Artist.search(@artist.name).first
      @artist_description = "#{@artist.name} is an artist on label X"
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
end
