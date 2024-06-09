require 'rails_helper'

RSpec.describe InventoryController, type: :controller do
  describe '#init_catalog' do
    let(:products) { [{ product_id: 1, product_name: 'Product 1', mass_kg: 10 }] }

    it 'initializes the catalog with provided products' do
      post :init_catalog, params: { products: products }
      expect(Product.count).to eq(1)
    end

    it 'responds with success status' do
      post :init_catalog, params: { products: products }
      expect(response).to have_http_status(:success)
    end
  end

  describe '#process_restock' do
    let!(:product) { create(:product, quantity: 5) }
    let(:restock_items) { [{ product_id: product.product_id, quantity: 3 }] }

    it 'restocks the products' do
      post :process_restock, params: { restock: restock_items }
      product.reload
      expect(product.quantity).to eq(8)
    end

    it 'responds with success status' do
      post :process_restock, params: { restock: restock_items }
      expect(response).to have_http_status(:success)
    end
  end

  describe '#process_order' do
    let(:product) { create(:product, quantity: 10) }
    let(:order_params) { { order_id: 1, requested: [{ product_id: product.product_id, quantity: 3 }] } }

    it 'creates an order with order items' do
      post :process_order, params: order_params
      order = Order.find_by(order_id: order_params[:order_id])
      expect(order.order_items.count).to eq(1)
    end

    it 'processes the order' do
      expect(controller).to receive(:process_order_shipping).once
      post :process_order, params: order_params
    end

    it 'responds with success status' do
      post :process_order, params: order_params
      expect(response).to have_http_status(:success)
    end
  end
end
