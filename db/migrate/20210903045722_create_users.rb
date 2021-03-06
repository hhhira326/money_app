class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :age
      t.string :sex
      t.string :family
      t.integer :rent
      t.integer :income
      t.integer :job_id
      t.string :password_digest
      t.string :avatar
      t.string :remember_digest
      t.integer :prefecture_id
      t.boolean :resign, null: false, default: false
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
