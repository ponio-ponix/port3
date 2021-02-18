class Memo < ApplicationRecord
  
  validates :title, presence: true, length: { in: 2..30 }
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  has_many :categorys
end
