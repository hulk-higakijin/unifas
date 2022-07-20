class Recruitment < ApplicationRecord
  belongs_to :professor
  belongs_to :faculty

  def university
    faculty.university
  end
end
