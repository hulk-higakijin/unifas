class CreateFaculties < ActiveRecord::Migration[7.0]
  def change
    create_table :faculties do |t|
      t.string :name, null: false
      t.references :university, null: false, foreign_key: true

      t.timestamps
    end
  end
end
