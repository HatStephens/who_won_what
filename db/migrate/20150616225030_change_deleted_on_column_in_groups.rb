class ChangeDeletedOnColumnInGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :deleted_on, :string
  end
end
