class Room < ApplicationRecord
  has_many :messages
  has_many :room_accounts
  has_many :accounts, through: :room_accounts

  def partner(current_account)
    accounts.includes(%i[professor candidate]).filter_map { |account| account.profile unless account.id == current_account.id }.first
  end
end
