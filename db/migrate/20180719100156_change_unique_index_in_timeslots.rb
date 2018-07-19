class ChangeUniqueIndexInTimeslots < ActiveRecord::Migration[5.1]
  def change
    remove_index :timeslots, [:day, :number, :course_id]
    add_index :timeslots, [:day, :number, :group_id], unique: true
  end
end
