class Playlists::PlaylistItemsController < ApplicationController 
  
  before_action :find_record, only: [:show, :next, :previous]
  before_action :find_list, only: [:index, :first, :last, :next, :previous]
  
  def show
  end
  
  def index
  end
  
  def first
    render json: @playlist_items.first
  end
  
  def last
    render json: @playlist_items.order(position: :desc).last
  end
  
  def next
    render json: @playlist_items.where("position > ?", @playlist_item.position).first
  end
  
  def previous
    render json: @playlist_items.where("position < ?", @playlist_item.position).last
  end
  
  private def find_record
    @playlist_item = PlaylistItem.find(params[:id])
  end
  
  private def find_list
    @playlist_items = PlaylistItem.where(playlist: params[:playlist_id]).order(:position)
  end
end
