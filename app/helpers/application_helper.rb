module ApplicationHelper
  def is_owner?(anno)
    current_user == anno.user ? true : false
  end
end
