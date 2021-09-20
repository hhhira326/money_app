# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..10).each do |num|
  user = User.new(name: "test #{num}", email: "test#{num}@test.com", age: num, job_id: num, sex: "test #{num}", family: "test #{num}", prefecture_id: num, rent: num, income: num, password: "test #{num}", password_confirmation: "test #{num}", avatar: "icon.png", resign: 'false')
  user.save
end