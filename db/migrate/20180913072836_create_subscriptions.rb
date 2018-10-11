class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.references :user
      t.integer :subscriber_id
      t.integer :subscribed_id
      t.string :stripe_subscription_id
      t.decimal :amount, precision: 10, scale: 2
      t.string :currency

      t.timestamps
    end

    add_index :subscriptions, :subscriber_id
    add_index :subscriptions, :subscribed_id
    add_index :subscriptions, [:subscriber_id, :subscribed_id], unique: true
    add_index :subscriptions, :stripe_subscription_id
  end
end
