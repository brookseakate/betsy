module ProductsHelper
  def stars(rating)
    int_rating = rating.to_i
    return (("&#x2605;" * int_rating) + ("&#x2606;" * (5 - int_rating) )).html_safe
  end
end
