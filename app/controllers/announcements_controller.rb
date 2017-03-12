class AnnouncementsController < ApplicationController
  expose :announcements, ->{ Announcement.all }
  expose :announcement

  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_owner, only: [:edit, :update, :destroy]

  def create
    announcement.user_id = current_user.id
    if announcement.save
      redirect_to announcement_path(announcement), notice: "Announcement created."
    else
      render :new
    end
  end

  def update
    if announcement.update(announcement_params)
      redirect_to announcement_path(announcement)
    else
      render :edit, notice: "Announcement updated."
    end
  end

  def destroy
    announcement.destroy
    redirect_to announcements_path, notice: "Announcement deleted."
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title, :description, :anno_type, :animal, :avatar)
  end

  def check_owner
    unless current_user == announcement.user_id
      redirect_to announcements_path, flash: {error: "Action restricted only for announcement owner"}
    end
  end
end
