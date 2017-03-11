class ChangeTypeToAnnotypeInAnnouncements < ActiveRecord::Migration[5.0]
  def change
    remove_column :announcements, :type, :string
    add_column :announcements, :anno_type, :string, null: false
  end
end
