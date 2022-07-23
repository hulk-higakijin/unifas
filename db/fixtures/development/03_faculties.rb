require 'csv'

csv = Rails.root.join('db', 'fixtures', 'csv', 'faculties.csv')

faculties = []
errors_list = []

CSV.foreach(csv, headers: true) do |row|
  university = University.find_by(name: row['大学名'])
  if university
    faculties << {
      name: row['学部名'],
      university_id: university.id
    }
  else
    errors_list.push(row['大学名'])
  end
end

Faculty.seed(faculties)

puts errors_list
