class AddIndexesToProductAndOrders < ActiveRecord::Migration[7.0]
  def change
    add_index :products, :product_id
    add_index :orders, :order_id
  end
end
