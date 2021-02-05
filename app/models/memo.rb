class Memo < ApplicationRecord
  has_many :categorys
  belongs_to :user
end
