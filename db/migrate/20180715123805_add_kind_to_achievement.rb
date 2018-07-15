class AddKindToAchievement < ActiveRecord::Migration[5.1]
  def change
    add_column :achievements, :kind, :integer, null: false, default: 0
  end
end
