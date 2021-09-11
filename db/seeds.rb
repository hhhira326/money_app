# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..10).each do |num|
  user = User.new(name: "test #{num}", email: "test #{num}", age: num, job: "test #{num}", sex: "test #{num}", family: num, address: "test #{num}", img: "test #{num}", rent: num, income: num, password_digest: "test #{num}", avatar: "test #{num}", remember_digest: "test #{num}")
  user.save
end