class Product < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  has_many :order_items
  has_and_belongs_to_many :categories

  validates :inventory,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def retire
    self.retired = true
  end

  def activate
    self.retired = false
  end

  def in_stock?
    return self.inventory > 0
  end

  def average_rating
    all_products = Product.all
    products_and_ratings = []

    # lines 86-98 (everything before the render) are collecting products ordered by the average rating in their reviews (descending) -ks
    @all_products.each do |product|
      reviews = product.reviews
      if !reviews.blank?
        ratings = reviews.map { |review| !review.rating.blank? ? review.rating : 0 }
        average_rating = ratings.reduce(:+)/ratings.length
      else
        average_rating = 0
      end

      @products_and_ratings << [product, average_rating]
    end

    @products = @products_and_ratings.sort_by { |arr| arr[1] }.map { |arr| arr[0] }.reverse
  end
end
