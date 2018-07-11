class AddUniqueIndexToGroups < ActiveRecord::Migration[5.1]
  def change
    add_index :groups, [:number, :parallel], unique: true
  end
end
