class CreateMoney < ActiveRecord::Migration[5.2]
  def change
    create_table :money do |t|
      t.integer :income
      t.integer :expense
      t.integer :income_category
      t.integer :expense_category
      t.timestamps
    end
  end
end
