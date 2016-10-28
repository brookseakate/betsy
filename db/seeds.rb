# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#User seed: creates 10 unique users
users = []
10.times do |user|
  users <<
  { email: Faker::Internet.email,
    user_name: Faker::Internet.user_name,
    uid: rand(1..5000),
    provider: "github"
  }
end

users.each do |user|
  User.create(user)
end

#Product Seed: creates 10 random products
products = []
10.times do |product|
  products << {
    description: Faker::Beer.style,
    inventory: rand(1..100),
    name: Faker::Beer.name,
    photo_url: Faker::Company.logo,
    price: rand(1..50000),
    retired: false,
    user_id: rand(1..10)
  }
end

products.each do |product|
  Product.create(product)
end

#Category seed
# categories = %w(Drinks Equipment Programming Thinkie Drinkie Fun Nerdy Awesome Drinkable Edible).shuffle
#
product_list = Product.all
# categories.length.times do |i|
#   product_id = product_list[i].id
#   category_hash = {name:"#{categories.pop}", product_ids: product_id}
#   Category.create(category_hash)
# end

#Review seed: assigns random number of reviews to all products
product_list.length.times do |product|
  review_hash = {
    rating: rand(1..5),
    review: "great stuff I love it so much",
    product_id: rand(1..10)
  }
  Review.create(review_hash)
end

#Orders seed: creates 5 orders with pending status. Note: exp date for credit card is not in a Month/Year format, might do elsewhere?
orders = []
5.times do |order|
  orders << {
    billing_zip: Faker::Address.zip_code,
    cc_holder_name: Faker::Name.name,
    cc_number: rand(100000..200000),
    cvv: rand(200..300),
    email: Faker::Internet.email,
    exp: Faker::Date.forward(500),
    mailing_address: Faker::Address.street_address,
    mailing_city: Faker::Address.city,
    mailing_state: Faker::Address.state,
    mailing_zip: Faker::Address.zip_code,
    status: "pending",
    placed: Faker::Date.between(2.days.ago, Date.today)
  }
end

orders.each do |order|
  Order.create(order)
end

#OrderItem seed: assigns random OrderItem object to a random order with associated product.
product_list.length.times do |product|
  order_item_hash = {
    quantity: rand(1..100),
    product_id: rand(1..10),
    order_id: rand(1..5)
  }
  OrderItem.create(order_item_hash)
end
