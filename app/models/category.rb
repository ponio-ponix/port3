class Category < ApplicationRecord
  belongs_to :user
  has_many :memos, dependent: :destroy
  enum is_active: {Availble: true, Invalid: false}
    validates :category_name, presence: true
end
