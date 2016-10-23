module ApplicationHelper
  def currency(amount)
    sprintf("$%0.02f", amount/100)
  end
end
