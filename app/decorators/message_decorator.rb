class MessageDecorator < Draper::Decorator
  delegate_all

  def create_details
    " [#{object.user.email} #{created_at}]"
  end

  def created_at
    object.created_at.strftime("%m/%d/%y %H:%M:%S")
  end

end
