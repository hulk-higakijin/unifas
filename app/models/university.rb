class University < ApplicationRecord
  belongs_to :prefecture
  has_many :faculties
end
