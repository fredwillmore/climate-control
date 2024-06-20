class PlaylistsController < ApplicationController
  def index
    redirect_to playlist_url(Playlist.first)
  end

  def show
    @playlist = Playlist.find(params[:id]) || Playlist.first
  end
end
