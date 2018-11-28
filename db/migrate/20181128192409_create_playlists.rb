class CreatePlaylists < ActiveRecord::Migration[5.0]
  def change
    create_table :playlists do |t|
      t.references :user
      t.string :title
      t.text :description
      t.text :image_data
      t.integer :policy_type, default: 0
      t.string :slug

      t.timestamps
    end
  end
end
