class Money < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :income_category
  belongs_to :expense_category
  

  validates :income, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}, format: { with: /\A[0-9]+\z/ }, if: :expenseCheck
  validates :expense, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}, format: { with: /\A[0-9]+\z/ }, if: :incomeCheck

  private
    def incomeCheck
      income.nil?
    end

    def expenseCheck
      expense.nil?
    end
end