# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# 30.times do |n|
# 	name = Faker::Name.name
# 	email = "user_#{n+1}@lehiep.com"
# 	password = "password"
# 	User.create!(name: name,
# 	email: email,
# 	password:
# 	password,
# 	password_confirmation: password)
# end

users = User.order(:created_at).take(6)
50.times do
content = Faker::Lorem.sentence(word_count: 5)
users.each { |user| user.microposts.create!(content: content) }
end