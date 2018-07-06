class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, :default => '', :null => false
      t.string :surname, :default => '', :null => false
      t.string :email, :unique => true, :null => false

      t.timestamps
    end
  end
end
