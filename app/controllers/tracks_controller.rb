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
    @track_description = "#{@track.name} is a track by #{@track.artist.name}"

    respond_to do |format|
      format.html
      format.json { render json: @track }
    end
  end
end
