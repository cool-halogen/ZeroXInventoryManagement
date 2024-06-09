FactoryBot.define do
  factory :product do
    product_id { Faker::Number.unique.number(digits: 5) }
    product_name { Faker::Commerce.product_name }
    mass_kg { Faker::Number.decimal(l_digits: 1, r_digits: 2) }
    quantity { Faker::Number.between(from: 0, to: 100) }
  end
end
