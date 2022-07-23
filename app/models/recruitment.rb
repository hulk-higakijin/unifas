class Recruitment < ApplicationRecord
  belongs_to :professor
  belongs_to :faculty

  validates :title, presence: true
  validates :body, presence: true
  validates :professor_id, presence: true
  validates :faculty_id, presence: true

  def university
    faculty.university
  end
end
