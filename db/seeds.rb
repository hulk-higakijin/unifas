account = Account.create!(email: 'professor@example.com', password: '123456', password_confirmation: '123456')
account.create_professor!(name: 'professor', introduction: 'hello, i am professor')

account = Account.create!(email: 'candidate@example.com', password: '123456', password_confirmation: '123456')
account.create_candidate!(name: 'candidate', introduction: 'hey! I am candidate...')