class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :age
      t.string :job
      t.string :sex
      t.integer :family
      t.string :address
      t.string :img
      t.integer :rent
      t.integer :income
      t.string :password_digest

      t.timestamps
    end
  end
end
