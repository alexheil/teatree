class CreateMerchants < ActiveRecord::Migration[5.0]
  def change
    create_table :merchants do |t|
      t.references :user
      t.string :stripe_publishable_key
      t.string :stripe_secret_key
      t.string :stripe_id
      t.string :first_name
      t.string :last_name
      t.string :currency
      t.string :country
      t.integer :month
      t.integer :day
      t.integer :year

      t.timestamps
    end
  end
end
