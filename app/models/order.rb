class Order < ActiveRecord::Base
  has_many :order_items


  # def self.status_options
  #   return ["pending", "paid", "complete", "cancelled"]
  # end # self.status_options
end
