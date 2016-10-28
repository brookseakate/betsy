require 'csv'

# users_list = []
#
# CSV.read("seed_csvs/users.csv").each do |line|
#   users_list.push(
#   {
#   # id: line[1],
#   user_name: line[1],
#   uid: line[2],
#   provider: line[3],
#   email: line[4]
# })
# end
#
# users_list.each do |user_hash|
#   User.create(user_hash)
# end

# products_list = []
#
# CSV.read("seed_csvs/products.csv").each do |line|
#   products_list.push(
#   {
#   # id: line[1],
#   user_id: line[1],
#   name: line[2],
#   price: line[3],
#   inventory: line[4],
#   description: line[5],
#   photo_url: line[6],
#   retired: line[7]
# })
# end
#
# products_list.each do |product_hash|
#   Product.create(product_hash)
# end


#ORDERS 
# orders_list = []
#
# CSV.read("seed_csvs/orders.csv").each do |line|
#   orders_list.push(
#   {
#   # id: line[1],
#   billing_zip: line[1],
#   cc_holder_name: line[2],
#   cc_number: line[3],
#   email: line[4],
#   cvv: line[5],
#   exp: line[6],
#   mailing_address: line[7],
#   mailing_city: line[8],
#   mailing_state: line[9],
#   mailing_zip: line[10],
#   status: line[11],
#   placed: line[12]
# })
# end
#
# orders_list.each do |order_hash|
#   Order.create(order_hash)
# end

#COME BACK TO THIS
# order_items_list = []
#
# CSV.read("seed_csvs/orderItems.csv").each do |line|
#   order_items_list.push(
#   {
#   # id: line[1],
#   order_id: line[1],
#   product_id: line[2],
#   quantity: line[3]
# })
# end
#
# order_items_list.each do |orderitem_hash|
#   OrderItem.create(orderitem_hash)
# end

# reviews_list = []
#
# CSV.read("seed_csvs/reviews.csv").each do |line|
#   reviews_list.push(
#   {
#   # id: line[1],
#   rating: line[1],
#   review: line[2],
#   product_id: line[3]
# })
# end
#
# reviews_list.each do |review_hash|
#   Review.create(review_hash)
# end


categories_list = []
CSV.read("seed_csvs/categories.csv").each do |line|
  categories_list.push(
  {
  # id: line[1], cannot be here
  name: line[1], #line starts at 0
  # product_id: line[2]
})
end

categories_list.each do |category_hash|
  Category.create(category_hash)
end









# OLD SEED DATA
# #User seed: creates 10 unique users
# users = []
# 10.times do |user|
#   users <<
#   { email: Faker::Internet.email,
#     user_name: Faker::Internet.user_name,
#     uid: rand(1..5000),
#     provider: "github"
#   }
# end
#
# users.each do |user|
#   User.create(user)
# end
#
# #Product Seed: creates 10 random products
# products = []
# 10.times do |product|
#   products << {
#     description: Faker::Beer.style,
#     inventory: rand(1..100),
#     name: Faker::Beer.name,
#     photo_url: Faker::Company.logo,
#     price: rand(1..50000),
#     retired: false,
#     user_id: rand(1..10)
#   }
# end
#
# products.each do |product|
#   Product.create(product)
# end
#
# #Category seed
# categories = %w(Drinks Equipment Programming Thinkie Drinkie Fun Nerdy Awesome Drinkable Edible).shuffle
#
# product_list = Product.all
# categories.length.times do |i|
#   product_id = product_list[i].id
#   category_hash = {name:"#{categories.pop}", product_ids: product_id}
#   Category.create(category_hash)
# end
#
# #Review seed: assigns random number of reviews to all products
# product_list.length.times do |product|
#   review_hash = {
#     rating: rand(1..5),
#     review: "great stuff I love it so much",
#     product_id: rand(1..10)
#   }
#   Review.create(review_hash)
# end
#
# #Orders seed: creates 5 orders with pending status. Note: exp date for credit card is not in a Month/Year format, might do elsewhere?
# orders = []
# 5.times do |order|
#   orders << {
#     billing_zip: Faker::Address.zip_code,
#     cc_holder_name: Faker::Name.name,
#     cc_number: rand(100000..200000),
#     cvv: rand(200..300),
#     email: Faker::Internet.email,
#     exp: Faker::Date.forward(500),
#     mailing_address: Faker::Address.street_address,
#     mailing_city: Faker::Address.city,
#     mailing_state: Faker::Address.state,
#     mailing_zip: Faker::Address.zip_code,
#     status: "pending",
#     placed: Faker::Date.between(2.days.ago, Date.today)
#   }
# end
#
# orders.each do |order|
#   Order.create(order)
# end
#
# #OrderItem seed: assigns random OrderItem object to a random order with associated product.
# product_list.length.times do |product|
#   order_item_hash = {
#     quantity: rand(1..100),
#     product_id: rand(1..10),
#     order_id: rand(1..5)
#   }
#   OrderItem.create(order_item_hash)
# end
