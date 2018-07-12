class AddThemeRefToLesson < ActiveRecord::Migration[5.1]
  def change
    add_reference :lessons, :theme, foreign_key: true
  end
end
