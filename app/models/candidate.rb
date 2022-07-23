class Candidate < ApplicationRecord
  belongs_to :account

  after_create :update_status

  private

    def update_status
      account.candidate!
    end
end
