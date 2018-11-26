class CreateSaves < ActiveRecord::Migration[5.0]
  def change
    create_table :saves do |t|
      t.references :user
      t.references :video

      t.timestamps
    end
  end
end
