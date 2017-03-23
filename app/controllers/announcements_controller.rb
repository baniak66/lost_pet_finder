class AnnouncementsController < ApplicationController
  expose :announcements_all, ->{ Announcement.all.where(open: true) }
  expose_decorated :announcements, ->{ Announcement.all.where(open: true).paginate(:page => params[:page], :per_page => 10)
 }
  expose_decorated :announcement_show, ->{ Announcement.includes(messages: [:user]).find(params[:id]) }
  expose :announcement
  expose :users_announcements, ->{ Announcement.all.where(user_id: current_user.id) }
  expose_decorated :message, -> { announcement.messages.new }

  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_owner, only: [:edit, :update, :destroy, :close]

  def show
    gon.announcement = announcement
  end

  def users
  end

  def close
    announcement.open = false
    announcement.save
    redirect_to users_announcements_path
  end

  def index
    gon.announcements = Gmaps4rails.build_markers(announcements_all) do |anno, marker|
      marker.lat anno.latitude
      marker.lng anno.longitude
      marker.infowindow "#{view_context.link_to "#{anno.title}", announcement_path(anno)}"
    end
  end

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
      redirect_to announcement_path(announcement), notice: "Announcement updated."
    else
      render :edit, notice: "Something went wrong."
    end
  end

  def destroy
    announcement.destroy
    redirect_to announcements_path, notice: "Announcement deleted."
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title, :description, :anno_type, :animal, :avatar, :place)
  end

  def check_owner
    unless current_user.id == announcement.user_id
      redirect_to announcements_path, flash: {error: "Action restricted only for announcement owner"}
    end
  end
end
