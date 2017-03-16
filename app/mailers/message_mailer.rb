class MessageMailer < ActionMailer::Base

  def new_message_email(user)
    @user = User.find(user)
    mail(to: @user.email, subject: 'New message on your announcement')
  end

end
