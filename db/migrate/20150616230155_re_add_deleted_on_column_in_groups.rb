class ReAddDeletedOnColumnInGroups < ActiveRecord::Migration
  def change
    add_column :groups, :deleted_on, :date
  end
end
