class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.integer :goalSavings
      t.date :goalDeadline
      t.string :category
      t.string :way
      t.integer :savings
      t.date :deadline
      t.boolean :check, null: false, default: false
      t.integer :user_id
      
      t.timestamps
    end
  end
end
