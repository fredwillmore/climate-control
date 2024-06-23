class TracksController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { 
        render json: Track.all 
      }
    end
  end
  
  def show
    @track = Track.find(params[:id])
    
    if spotify_track = RSpotify::Track.search("#{@track.display_name} - #{@track.artist.name}").first
      @spotify_url = spotify_track.external_urls['spotify']
      @track_description = "#{spotify_track.name} is a track by #{spotify_track.artists.map(&:name).join(', ')}."
      @track_album_description = "It appears on the album #{spotify_track.album.name}"
    end

    respond_to do |format|
      format.html
      format.json { render json: @track }
    end
  end
end
