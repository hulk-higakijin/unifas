class Professor < ApplicationRecord
  belongs_to :account

  after_create :update_status

  private

    def update_status
      account.professor!
    end
end
