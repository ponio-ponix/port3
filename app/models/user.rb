class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  validates :name, presence: true, length: { in: 2..20 }
  validates :introduction, length: { in: 2..100}
  has_many :memos
end
