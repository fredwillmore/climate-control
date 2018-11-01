class Playlists::PlaylistItemsController < ApplicationController 
  def show
    render json: PlaylistItem.find(params[:id])
  end
  
  def index
    render json: PlaylistItem.where(playlist: params[:playlist_id])
  end
end
