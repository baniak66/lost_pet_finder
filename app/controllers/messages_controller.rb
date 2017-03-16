class MessagesController < ApplicationController
  expose :message

  before_action :authenticate_user!

  def create
    if message.save
      redirect_to announcement_path(message.announcement_id)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :announcement_id, :user_id)
  end
end