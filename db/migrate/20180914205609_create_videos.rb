class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.references :user
      t.references :category
      t.references :subcategory
      t.string :title
      t.text :video_data
      t.text :image_data
      t.text :description
      t.integer :policy_type, default: 0
      t.integer :view_count, default: 0
      t.string :slug

      t.timestamps
    end

    add_index :videos, :slug, unique: true
  end
end
