class CreateRoomAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :room_accounts do |t|
      t.references :room, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
