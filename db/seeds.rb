# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..50).each do |num|
  User.create(name: "test#{num}", email: "test#{num}@test.com", age: num, job_id: num, sex: "test#{num}", family: "test#{num}", prefecture_id: num, rent: num, income: num, password: "test#{num}", password_confirmation: "test#{num}", avatar: "icon.png", resign: 'false', admin: 'false')
end
adminUser = User.first
adminUser.update(admin: true)

(1..12).each do |num|
  user = User.first
  if num > 10
    user.money.create(income: num * 10000, expense: nil, income_category_id: 1, expense_category_id: nil, details: "test#{num}", user_id: 1, created_at: "2020-#{num}-23 00:00:00")
    user.money.create(income: num * 1000, expense: nil, income_category_id: 2, expense_category_id: nil, details: "test#{num}", user_id: 1, created_at: "2020-#{num}-05 00:00:00")
    user.money.create(income: nil, expense: num * 100, income_category_id: nil, expense_category_id: 1, details: "test#{num}", user_id: 1, created_at: "2020-#{num}-21 00:00:00")
    user.money.create(income: nil, expense: num * 100, income_category_id: nil, expense_category_id: 10, details: "test#{num}", user_id: 1, created_at: "2020-#{num}-23 00:00:00")
    user.money.create(income: nil, expense: num * 100, income_category_id: nil, expense_category_id: 11, details: "test#{num}", user_id: 1, created_at: "2020-#{num}-23 00:00:00")
  elsif num < 10
    user.money.create(income: num * 100000, expense: nil, income_category_id: 1, expense_category_id: nil, details: "test#{num}", user_id: 1, created_at: "2021-0#{num}-25 00:00:00")
    user.money.create(income: num * 10000, expense: nil, income_category_id: 2, expense_category_id: nil, details: "test#{num}", user_id: 1, created_at: "2021-0#{num}-25 00:00:00")
    user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: num, details: "test#{num}", user_id: 1, created_at: "2021-0#{num}-25 00:00:00")
    user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: 1, details: "test#{num}", user_id: 1, created_at: "2021-0#{num}-25 00:00:00")
    user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: 2, details: "test#{num}", user_id: 1, created_at: "2021-0#{num}-25 00:00:00")
    user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: 10, details: "test#{num}", user_id: 1, created_at: "2021-0#{num}-25 00:00:00")
    user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: 11, details: "test#{num}", user_id: 1, created_at: "2021-0#{num}-25 00:00:00")
  else
    user.money.create(income: num * 100000, expense: nil, income_category_id: 1, expense_category_id: nil, details: "test#{num}", user_id: 1, created_at: "2021-#{num}-23 00:00:00")
    user.money.create(income: num * 10000, expense: nil, income_category_id: 2, expense_category_id: nil, details: "test#{num}", user_id: 1, created_at: "2021-#{num}-05 00:00:00")
    user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: 1, details: "test#{num}", user_id: 1, created_at: "2021-#{num}-21 00:00:00")
    user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: 10, details: "test#{num}", user_id: 1, created_at: "2021-#{num}-23 00:00:00")
    user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: 11, details: "test#{num}", user_id: 1, created_at: "2021-#{num}-23 00:00:00")
  end
end

(1..12).each do |num|
  user = User.first
  if num > 10
    user.money.create(income: num * 10000, expense: nil, income_category_id: 1, expense_category_id: nil, details: "test#{num}", user_id: 1, created_at: "2020-#{num}-23 00:00:00")
    user.money.create(income: num * 1000, expense: nil, income_category_id: 2, expense_category_id: nil, details: "test#{num}", user_id: 1, created_at: "2020-#{num}-05 00:00:00")
    user.money.create(income: nil, expense: num * 100, income_category_id: nil, expense_category_id: 1, details: "test#{num}", user_id: 1, created_at: "2020-#{num}-21 00:00:00")
    user.money.create(income: nil, expense: num * 100, income_category_id: nil, expense_category_id: 10, details: "test#{num}", user_id: 1, created_at: "2020-#{num}-23 00:00:00")
    user.money.create(income: nil, expense: num * 100, income_category_id: nil, expense_category_id: 11, details: "test#{num}", user_id: 1, created_at: "2020-#{num}-23 00:00:00")
  elsif num < 10
    user.money.create(income: num * 100000, expense: nil, income_category_id: 1, expense_category_id: nil, details: "test#{num}", user_id: 1, created_at: "2021-0#{num}-25 00:00:00")
    user.money.create(income: num * 10000, expense: nil, income_category_id: 2, expense_category_id: nil, details: "test#{num}", user_id: 1, created_at: "2021-0#{num}-25 00:00:00")
    user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: num, details: "test#{num}", user_id: 1, created_at: "2021-0#{num}-25 00:00:00")
    user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: 1, details: "test#{num}", user_id: 1, created_at: "2021-0#{num}-25 00:00:00")
    user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: 2, details: "test#{num}", user_id: 1, created_at: "2021-0#{num}-25 00:00:00")
    user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: 10, details: "test#{num}", user_id: 1, created_at: "2021-0#{num}-25 00:00:00")
    user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: 11, details: "test#{num}", user_id: 1, created_at: "2021-0#{num}-25 00:00:00")
  else
    user.money.create(income: num * 100000, expense: nil, income_category_id: 1, expense_category_id: nil, details: "test#{num}", user_id: 1, created_at: "2021-#{num}-23 00:00:00")
    user.money.create(income: num * 10000, expense: nil, income_category_id: 2, expense_category_id: nil, details: "test#{num}", user_id: 1, created_at: "2021-#{num}-05 00:00:00")
    user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: 1, details: "test#{num}", user_id: 1, created_at: "2021-#{num}-21 00:00:00")
    user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: 10, details: "test#{num}", user_id: 1, created_at: "2021-#{num}-23 00:00:00")
    user.money.create(income: nil, expense: num * 1000, income_category_id: nil, expense_category_id: 11, details: "test#{num}", user_id: 1, created_at: "2021-#{num}-23 00:00:00")
  end
end