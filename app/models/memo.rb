class Memo < ApplicationRecord
  
  belongs_to :user
  has_many :comments
  has_many :favorites
  has_many :categorys
end
