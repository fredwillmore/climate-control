class TracksController < ApplicationController
  def index
    respond_to do |format|
      format.json { 
        render json: Track.all 
      }
    end
  end
  
  def show
    respond_to do |format|
      format.json { 
        render json: Track.find(params[:id]) 
      }
    end
  end
end
