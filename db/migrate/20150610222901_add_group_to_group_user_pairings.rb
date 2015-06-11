class AddGroupToGroupUserPairings < ActiveRecord::Migration
  def change
    add_reference :group_user_pairings, :group, index: true
    add_foreign_key :group_user_pairings, :groups
  end
end
