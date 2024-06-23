class HomeController < ApplicationController
  def home
    @playlist = Playlist.first
  end
end
