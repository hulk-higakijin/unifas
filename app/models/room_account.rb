class RoomAccount < ApplicationRecord
  belongs_to :room
  belongs_to :account
end
