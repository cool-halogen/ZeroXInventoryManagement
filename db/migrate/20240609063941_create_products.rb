class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.integer :product_id
      t.string :product_name
      t.float :mass_kg
      t.integer :quantity

      t.timestamps
    end
  end
end
