class University < ApplicationRecord
  belongs_to :prefecture
  has_many :faculties

  default_scope { order(:prefecture_id, :id) }
  scope :active, -> { where(active: true) }
  # scope :result, ->(params) { active.where('name LIKE(?)', "%#{params[:name]}%").page(params[:page]).per(24) }
end
