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
    @track_description = "#{@track.name} is a track by #{@track.artist.name}. It appears on the album #{}"

    if spotify_track = RSpotify::Track.search(@track.name).first
      @track_album_description = "It appears on the album #{spotify_track.album.name}"
    end

    respond_to do |format|
      format.html
      format.json { render json: @track }
    end
  end
end
