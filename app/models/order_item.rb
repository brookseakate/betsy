class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :order, presence: true
  validates :product, presence: true
  
  validates :quantity,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }

  def subtotal
    self.product.price * self.quantity
  end
end
