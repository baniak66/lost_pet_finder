class CreateAnnouncements < ActiveRecord::Migration[5.0]
  def change
    create_table :announcements do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :type, null: false
      t.boolean :open, null: false, default: true
      t.string :animal

      t.timestamps
    end
  end
end
