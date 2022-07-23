class CreateProfessors < ActiveRecord::Migration[7.0]
  def change
    create_table :professors do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name, null: false
      t.text :introduction

      t.timestamps
    end
  end
end
