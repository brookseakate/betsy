class User < ActiveRecord::Base
  has_many :products
  has_many :order_items, through: :products


def self.search(search)
  if search
    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  else
    find(:all)
  end
end
end
