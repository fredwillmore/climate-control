class ArtistsController < ApplicationController
  def index
    respond_to do |format|
      format.json { 
        render json: Artist.all 
      }
    end
  end

  def show
    respond_to do |format|
      format.json { 
        render json: Artist.find(params[:id]) 
      }
    end
  end
end
