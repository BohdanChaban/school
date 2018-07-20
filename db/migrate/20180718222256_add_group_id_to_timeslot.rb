class AddGroupIdToTimeslot < ActiveRecord::Migration[5.1]
  def change
    add_column :timeslots, :group_id, :bigint
  end
end
