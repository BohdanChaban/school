class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, default: ''
      t.string :surname, null: false, default: ''
      t.string :email, unique: true, null: false, default: ''

      t.timestamps
    end
  end
end
