class Message < ApplicationRecord
  belongs_to :announcement
  belongs_to :user

  validates :content, :user_id, :announcement_id, presence: true
end
