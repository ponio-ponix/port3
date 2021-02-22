class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :memo
  validates :body, presence: true, length: { in: 2..30 }
end
