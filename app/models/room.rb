class Room < ApplicationRecord
  has_many :messages
  has_many :room_accounts
  has_many :accounts, through: :room_accounts
end
