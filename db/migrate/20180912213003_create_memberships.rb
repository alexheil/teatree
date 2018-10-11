class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.references :user
      t.string :stripe_subscription_id, default: ""
      t.string :current_id, default: ""
      t.integer :membership_type, default: 0

      t.timestamps
    end

    add_index :memberships, :stripe_subscription_id
  end
end
