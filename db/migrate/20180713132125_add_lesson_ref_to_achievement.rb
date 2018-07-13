class AddLessonRefToAchievement < ActiveRecord::Migration[5.1]
  def change
    add_reference :achievements, :lesson, foreign_key: true
  end
end
