require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "associations" do
    it { should have_many(:order_items) }
    it { should have_many(:orders).through(:order_items) }
  end
end
