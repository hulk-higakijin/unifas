class Faculty < ApplicationRecord
  belongs_to :university
  has_many :recruitments
  has_many :researches
end
