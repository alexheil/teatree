class CreateSubcategories < ActiveRecord::Migration[5.0]
  def change
    create_table :subcategories do |t|
      t.references :category
      t.string :title
      t.text :description
      t.string :image
      t.string :slug

      t.timestamps
    end

    add_index :subcategories, :slug, unique: true
  end
end
