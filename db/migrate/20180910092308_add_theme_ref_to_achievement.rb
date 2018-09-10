class AddThemeRefToAchievement < ActiveRecord::Migration[5.1]
  def change
    add_reference :achievements, :theme, foreign_key: true
  end
end
