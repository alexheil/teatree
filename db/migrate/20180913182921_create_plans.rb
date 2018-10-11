class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.references :user
      t.string :plan_id
      t.string :product_id
      t.decimal :amount, precision: 10, scale: 2
      t.string :currency

      t.timestamps
    end

    add_index :plans, :plan_id
    add_index :plans, :product_id
  end
end
