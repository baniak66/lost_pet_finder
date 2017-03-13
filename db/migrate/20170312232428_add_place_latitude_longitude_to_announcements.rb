class AddPlaceLatitudeLongitudeToAnnouncements < ActiveRecord::Migration[5.0]
  def change
    add_column :announcements, :place, :string
    add_column :announcements, :latitude, :float
    add_column :announcements, :longitude, :float
  end
end
