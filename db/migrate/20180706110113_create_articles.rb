# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :topic, null: false, default: ''
      t.string :summary
      t.string :body

      t.timestamps
    end
  end
end
