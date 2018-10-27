class Playlist < ApplicationRecord
  has_many :playlist_items
  has_many :tracks, through: :playlist_items
end
