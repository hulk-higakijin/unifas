class Professor < ApplicationRecord
  belongs_to :account

  after_create :update_status

  private

    def update_status
      self.account.professor!
    end
end
