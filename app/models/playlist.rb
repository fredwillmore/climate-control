class Playlist < ApplicationRecord
  has_many :playlist_items
  has_many :tracks, through: :playlist_items

  def next
    self.class.where("date > ?", date).first
  end

  def previous
    self.class.where("date < ?", date).last
  end

end
