class AnnouncementsController < ApplicationController
  expose :announcements, ->{ Announcement.all }
  expose :announcement

  def index
  end

  def show
  end

end
