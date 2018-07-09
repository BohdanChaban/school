class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.string :name, unique: true, null: false, default: ''
      t.string :image, null: false, default: ''
      t.timestamps
    end
  end
end
