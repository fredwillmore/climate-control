class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :comments
      t.belongs_to :artist, index: true, foreign_key: true
      t.timestamps
    end
  end
end
