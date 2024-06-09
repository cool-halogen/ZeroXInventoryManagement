class InventoryController < ApplicationController
  MAX_PACKAGE_WEIGHT = 134.8

  def init_catalog
    Product.delete_all
    params[:products].each do |product_info|
      Product.create(
        product_id: product_info[:product_id],
        product_name: product_info[:product_name],
        mass_kg: product_info[:mass_kg],
        quantity: 0
      )
    end
    render json: { status: 'Catalog initialized' }
  end

  def process_restock
    params[:restock].each do |item|
      product = Product.find_by(product_id: item[:product_id])
      product.update(quantity: product.quantity + item[:quantity].to_i) # Convert to integer
    end
    process_pending_orders
    render json: { status: 'Restock processed' }
  end

  def process_order
    order = Order.create(order_id: params[:order_id])
    params[:requested].each do |item|
      order.order_items.create(product: Product.find_by(product_id: item[:product_id]), quantity: item[:quantity])
    end
    process_order_shipping(order)
    render json: { status: 'Order processed' }
  end

  private

  def process_pending_orders
    Order.all.each do |order|
      process_order_shipping(order)
    end
  end

  def process_order_shipping(order)
    order_items = order.order_items.joins(:product).select('order_items.id', 'order_items.order_id', 'order_items.product_id', 'order_items.quantity', 'products.mass_kg')

    total_weight = 0
    shipment = { order_id: order.order_id, shipped: [] }

    order_items.each do |order_item|
      while order_item.quantity > 0 && order_item.product.quantity > 0
        shipment_quantity = [order_item.quantity, (MAX_PACKAGE_WEIGHT / order_item.product.mass_kg).floor, order_item.product.quantity].min
        total_weight += shipment_quantity * order_item.product.mass_kg

        if total_weight > MAX_PACKAGE_WEIGHT
          ship_package(shipment)
          total_weight = 0
          shipment[:shipped].clear
        end

        shipment[:shipped] << { product_id: order_item.product.product_id, quantity: shipment_quantity }
        order_item.update(quantity: order_item.quantity - shipment_quantity)
        order_item.product.update(quantity: order_item.product.quantity - shipment_quantity)
      end
    end

    ship_package(shipment) unless shipment[:shipped].empty?
  end

  def ship_package(shipment)
    puts shipment.to_json
  end
end
