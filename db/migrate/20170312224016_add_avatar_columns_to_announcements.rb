class AddAvatarColumnsToAnnouncements < ActiveRecord::Migration[5.0]
  def up
    add_attachment :announcements, :avatar
  end

  def down
    remove_attachment :announcements, :avatar
  end
end
