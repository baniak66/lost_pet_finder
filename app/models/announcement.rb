class Announcement < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  validates :title, :description, :open, :animal, :anno_type, :user_id, :place, presence: true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  geocoded_by :place
  after_validation :geocode
end
