class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum status: { unidentified: 0, candidate: 1, professor: 2 }

  has_one :professor
  has_one :candidate
  has_many :messages
  has_many :room_accounts
  has_many :rooms, through: :room_accounts

  def profile
    if professor?
      professor
    elsif candidate?
      candidate
    end
  end
end
