class CreatePlaylistItems < ActiveRecord::Migration[5.2]
  def change
    create_table :playlist_items do |t|
      t.integer :position
      t.belongs_to :track
      t.belongs_to :playlist
      t.timestamps
    end
  end
end
