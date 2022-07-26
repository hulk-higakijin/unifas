class CreateResearches < ActiveRecord::Migration[7.0]
  def change
    create_table :researches do |t|
      t.string :title, null: false
      t.text :body
      t.references :professor, null: false, foreign_key: true
      t.references :faculty, null: false, foreign_key: true

      t.timestamps
    end
  end
end
