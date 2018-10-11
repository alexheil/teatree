class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user
      t.string :display_name
      t.string :first_name
      t.string :last_name
      t.text :image_data
      t.string :age, default: ""
      t.string :city, default: ""
      t.string :state, default: ""
      t.string :country, default: ""
      t.string :website, default: ""
      t.string :twitter_handle, default: ""
      t.string :twitter_url, default: ""
      t.string :instagram_handle, default: ""
      t.string :instagram_url, default: ""
      t.string :snapchat_handle, default: ""
      t.string :snapchat_url, default: ""
      t.text :biography, default: ""

      t.timestamps
    end
  end
end
