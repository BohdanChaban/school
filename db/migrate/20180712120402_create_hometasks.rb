class CreateHometasks < ActiveRecord::Migration[5.1]
  def change
    create_table :hometasks do |t|
      t.string :description, null: false
      t.string :link, null: false, default: ''
      t.references :lesson, foreign_key: true

      t.timestamps
    end
  end
end
