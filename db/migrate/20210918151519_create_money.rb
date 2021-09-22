class CreateMoney < ActiveRecord::Migration[5.2]
  def change
    create_table :money do |t|
      t.integer :income
      t.integer :expense
      t.integer :income_category_id
      t.integer :expense_category_id
      t.text :details
      t.integer :user_id
      t.timestamps
    end
  end
end
