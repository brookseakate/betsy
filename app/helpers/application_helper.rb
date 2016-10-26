module ApplicationHelper
  def currency(amount)
    sprintf("$%0.02f", amount/100.to_f)
  end

  def pretty_date(datetime)
    datetime.strftime("%I:%M %p, %A, %B %d, %Y (%Z)")
  end

  def user_name
    begin
      user = User.find(session[:user_id])
      if user.user_name
        return user.name
      else
        return "Guest"
      end
    rescue ActiveRecord::RecordNotFound
      return "ERROR: user not in database"
    end
  end

  def login_status
    if session[:user_id].nil?
      "Viewing as #{user_name}"
    else
      "Logged in as #{user_name}"
    end
  end
end
