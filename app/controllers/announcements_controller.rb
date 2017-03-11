class AnnouncementsController < ApplicationController
  expose :announcements, ->{ Announcements.all }

  def index
  end

end
