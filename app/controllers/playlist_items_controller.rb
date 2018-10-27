class PlaylistItemsController < ApplicationController
  def index
    respond_to do |format|
      format.json { 
        render json: PlaylistItem.all 
      }
    end
  end

  def show
    respond_to do |format|
      format.json { 
        render json: PlaylistItem.find(params[:id]) 
      }
    end
  end

end
