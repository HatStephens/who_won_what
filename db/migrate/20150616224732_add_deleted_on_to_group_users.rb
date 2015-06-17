class AddDeletedOnToGroupUsers < ActiveRecord::Migration
  def change
    add_column :group_users, :deleted_on, :date
  end
end
