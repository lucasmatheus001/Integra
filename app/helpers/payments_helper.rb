module PaymentsHelper
  def post_date(date)
    # formatting date: Aug, 31 2007 - 9:55PM
    date.strftime("%d - %m - %Y - %H:%M")
  end
end
