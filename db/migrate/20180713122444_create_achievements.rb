class CreateAchievements < ActiveRecord::Migration[5.1]
  def change
    create_table :achievements do |t|
      t.integer :points, null: false
      t.boolean :attendance, null: false, default: true

      t.timestamps
    end
  end
end
