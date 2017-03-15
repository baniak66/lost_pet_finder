class Message < ApplicationRecord
  belongs_to :announcement
  belongs_to :user
end
