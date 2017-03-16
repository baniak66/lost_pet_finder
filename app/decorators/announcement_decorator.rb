class AnnouncementDecorator < Draper::Decorator
  delegate_all
  decorates_association :messages

  def create_details
    "Created by: #{object.user.email} on #{created_at}"
  end

  def created_at
    object.created_at.strftime("%a %m/%d/%y")
  end
end
