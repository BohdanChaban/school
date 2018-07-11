class CreateThemes < ActiveRecord::Migration[5.1]
  def change
    create_table :themes do |t|
      t.string :topic, null: false, default: ''
      t.text :description, null: false, default: ''
      t.text :links, null: false, default: ''

      t.timestamps
    end
  end
end
