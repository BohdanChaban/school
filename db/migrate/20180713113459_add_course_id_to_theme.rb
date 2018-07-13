class AddCourseIdToTheme < ActiveRecord::Migration[5.1]
  def change
    add_column :themes, :course_id, :bigint
  end
end
