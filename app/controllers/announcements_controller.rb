class AnnouncementsController < ApplicationController
  expose :announcements, ->{ Announcement.all }
  expose :announcement

  before_action :authenticate_user!, except: [:index, :show]

  def create
    announcement.user_id = current_user.id
    if announcement.save
      redirect_to announcement_path(announcement)
    else
      render :new
    end
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title, :description, :anno_type, :animal)
  end

end
