# rubocop:disable Metrics/BlockLength
# frozen_string_literal: true

namespace :seed_db_data do
  task admin: :environment do
    ActiveRecord::Base.transaction do
      admin1 = User.admin.new(name: 'Anurag', mobile_number: '11111111')
      admin1.save!

      p1 = Product.new(product_id: 1, name: 'Coconut oil', category: '200ml', price: 40).save!
      p2 = Product.new(product_id: 2, name: 'Hair oil', category: '200ml', price: 50).save!
      Product.new(product_id: 2, name: 'Hair oil', category: '400ml', price: 80).save!

      admin1.inventories.new(product_id: 1, quantity: 20).save!
      admin1.inventories.new(product_id: 2, quantity: 30).save!
      admin1.inventories.new(product_id: 3, quantity: 5).save!

      Sale.new(seller_id: admin1.id, customer_id: Customer.first.id, product_id: p1.id,
               product_name: p1.name, quantity: 5, price: 40, date_of_purchase: DateTime.current).save!
      Sale.new(seller_id: admin1.id, customer_id: Customer.second.id, product_id: p2.id,
               product_name: p2.name, quantity: 5, price: 40, date_of_purchase: DateTime.current).save!
      Sale.new(seller_id: admin1.id, customer_id: Customer.first.id, product_id: p1.id,
               product_name: p1.name, quantity: 5, price: 40, date_of_purchase: DateTime.current).save!
      Sale.new(seller_id: admin1.id, customer_id: Customer.first.id, product_id: p1.id,
               product_name: p1.name, quantity: 5, price: 30, date_of_purchase: DateTime.current).save!
    end
  end

  task customer: :environment do
    ActiveRecord::Base.transaction do
      Customer.new(name: 'Canurag uapadeh', mobile_number: '7327062263').save!
      Customer.new(name: 'banurag uapadeh', mobile_number: '7327062243').save!
      Customer.new(name: 'hurag uapadeh', mobile_number: '7322062243').save!
    end
  end
end

# rubocop:enable Metrics/BlockLength
