class RemoveGroupIndividualGroupUsersFixtures < ActiveRecord::Migration
  def change
    remove_column :fixtures, :group_user_one, :integer
    remove_column :fixtures, :group_user_two, :integer
  end
end
