class Track < ApplicationRecord
  belongs_to :artist
  has_many :playlist_items
  has_many :playlists, through: :playlist_item
end
