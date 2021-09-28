class Money < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :income_category
  belongs_to :expense_category

  def self.search(search_date)
    where("created_at LIKE ?" , "%#{search_date}%")
  end
end
