class AddColumnToCourse < ActiveRecord::Migration[5.1]
  def change
    change_table :courses do |t|
      t.boolean :displayed, null: false, default: true
    end

    add_column :courses, :group_id, :bigint
    add_column :courses, :subject_id, :bigint
    add_column :courses, :user_id, :bigint
  end
end
