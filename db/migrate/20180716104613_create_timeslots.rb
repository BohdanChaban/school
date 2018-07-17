class CreateTimeslots < ActiveRecord::Migration[5.1]
  def change
    create_table :timeslots do |t|
      t.integer :day, null: false, default: 0
      t.integer :number, null: false, default: 1
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
