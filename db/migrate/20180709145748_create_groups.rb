class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.integer :number, null: false
      t.string :parallel, null: false

      t.timestamps
    end
  end
end
