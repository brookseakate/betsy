class Product < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  has_many :order_items
  has_and_belongs_to_many :categories

  def retire
    self.retired = true
  end

  def activate
    self.retired = false
  end
end
