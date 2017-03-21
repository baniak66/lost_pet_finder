class MessagesController < ApplicationController
  expose :message
  expose :announcement

  before_action :authenticate_user!

  def create
    if message.save
      redirect_to announcement_path(message.announcement_id), notice: "Message created!"
      unless message.user_id == message.announcement.user_id
        MessageMailer.new_message_email(message.announcement.user_id).deliver_later
      end
    else
      redirect_to announcement_path(announcement), flash: {error: "Something went wrong, try again."}
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :announcement_id, :user_id)
  end
end
