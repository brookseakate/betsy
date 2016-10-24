module ApplicationHelper
  def currency(amount)
    sprintf("$%0.02f", amount/100.to_f)
  end

  def pretty_date(datetime)
    datetime.strftime("%I:%M %p, %A, %B %d, %Y (%Z)")
  end
end
