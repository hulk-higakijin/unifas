class CreateUniversities < ActiveRecord::Migration[7.0]
  def change
    create_table :universities do |t|
      t.string :name, null: false
      t.text :note
      t.references :prefecture, null: false, foreign_key: true
      t.text :url
      t.boolean :active, default: false
      t.text :introduction

      t.timestamps
    end
  end
end
