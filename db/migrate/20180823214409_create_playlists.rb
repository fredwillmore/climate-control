class CreatePlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :playlists do |t|
      t.date :date
      t.integer :position 
      t.timestamps
    end
  end
end
