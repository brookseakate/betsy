class Product < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  has_many :order_items
  has_and_belongs_to_many :categories

  validates :inventory,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0,  }
    validates :price,
    presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than: 20000}
    validates :name,
    presence: true, uniqueness: true

  def retire
    self.retired = true
  end

  def activate
    self.retired = false
  end

  def in_stock?
    return self.inventory > 0
  end
end
