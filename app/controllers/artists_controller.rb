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
    @artist_description = "#{@artist.name} is an artist - TODO: get artist info"
  
    respond_to do |format|
      format.html
      format.json { 
        render json: @artist
      }
    end
  end
end
