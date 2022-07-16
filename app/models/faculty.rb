class Faculty < ApplicationRecord
  belongs_to :university
  has_many :recruitments
end
