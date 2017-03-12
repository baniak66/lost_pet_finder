class AddUserToAnnouncements < ActiveRecord::Migration[5.0]
  def change
    add_reference :announcements, :user, foreign_key: true, index: true
  end
end
