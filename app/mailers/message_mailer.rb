class MessageMailer < ActionMailer::Base
  default from: "info@lostpetfinder.com"

  def new_message_email(user)
    @user = User.find(user)
    mail(to: @user.email, subject: 'New message on your announcement')
  end

end
