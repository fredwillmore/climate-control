class PlaylistsController < ApplicationController
  def index
    respond_to do |format|
      format.html { 
        render
      }
      format.json { render json: Playlist.all }
    end
  end

  def show
    respond_to do |format|
      format.json { 
        render json: Playlist.find(params[:id])
      }
    end
  end
end
