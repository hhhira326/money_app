# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..50).each do |num|
  User.create(name: "test#{num}", email: "test#{num}@test.com", age: num, job_id: num, sex: "test#{num}", family: "test#{num}", prefecture_id: num, rent: num, income: num, password: "test#{num}", password_confirmation: "test#{num}", avatar: "icon.png", resign: 'false')
end
(1..9).each do |num|
  user = User.first
  user.money.create(income: num * 100000, expense: nil, income_category_id: 1, expense_category_id: nil, details: "test#{num}", user_id: 1, created_at: "2021-0#{num}-25 00:00:00", updated_at: "2021-09-24 17:16:14")
  user.money.create(income: num * 10000, expense: nil, income_category_id: 2, expense_category_id: nil, details: "test#{num}", user_id: 1, created_at: "2021-0#{num}-25 00:00:00", updated_at: "2021-09-24 17:16:14")
  user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: num, details: "test#{num}", user_id: 1, created_at: "2021-0#{num}-25 00:00:00", updated_at: "2021-09-24 17:16:14")
end
(1..9).each do |num|
  user = User.first
  user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: num, details: "test#{num}", user_id: 1, created_at: "2021-09-25 00:00:00", updated_at: "2021-09-24 17:16:14")
  user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: num, details: "test#{num}", user_id: 1, created_at: "2021-10-25 00:00:00", updated_at: "2021-09-24 17:16:14")

end
user = User.first
user.money.create(income: 100000, expense: nil, income_category_id: 1, expense_category_id: nil, details: "test", user_id: 1, created_at: "2021-10-05 00:00:00", updated_at: "2021-10-05 17:16:14")
user.money.create(income: 100000, expense: nil, income_category_id: 2, expense_category_id: nil, details: "test", user_id: 1, created_at: "2021-10-05 00:00:00", updated_at: "2021-10-05 17:16:14")

