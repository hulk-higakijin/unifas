require 'csv'

csv = Rails.root.join('db', 'fixtures', 'csv', 'universities.csv')

universities = []

CSV.foreach(csv, headers: true) do |row|
  universities << {
    name: row['大学名'],
    prefecture_id: row['都道府県ID'],
    url: row['URL'],
    note: row['備考'],
    active: row["is_active"] == 'FALSE' ? false : true
  }
end

University.seed(universities)
