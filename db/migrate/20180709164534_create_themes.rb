class CreateThemes < ActiveRecord::Migration[5.1]
  def change
    create_table :themes do |t|
      t.string :topic
      t.text :description
      t.text :links
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
