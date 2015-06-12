class AddDeletedOnToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :deleted_on, :string
    add_column :groups, :date, :string
  end
end
