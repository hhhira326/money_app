class Money < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :income_category
  belongs_to :expense_category

  # @salaryOct = @salary.where("created_at LIKE ?", "%#{year}-10%")
  # @salaryOctVal = 0
  # @salaryOct.each do |i|
  #   @salaryOctVal += i.income
  # end

  # def MonthSeparate(year, name, val, cate, money)
  #   name =
  #   for (let i = 1; i < 9; i++) do
  #     name += cate.where("created_at LIKE ?", "%year%-0#{i}")
      
  #   end
  #   for (let i = 10; i < 12; i++) do
  #     name = cate.where("created_at LIKE ?", "%year%-#{i}")
  #   end
  #   val = 0
  #   name.each do |i|
  #     val += i.money
  #   end
    
  # end
end
