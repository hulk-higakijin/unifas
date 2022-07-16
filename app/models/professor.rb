class Professor < ApplicationRecord
  belongs_to :account
  has_many :recruitments

  after_create :update_status

  private

    def update_status
      account.professor!
    end
end
