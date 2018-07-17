class AddUniqueIndexToTimeslots < ActiveRecord::Migration[5.1]
  def change
    add_index :timeslots, [:day, :number, :course_id], unique: true
  end
end
