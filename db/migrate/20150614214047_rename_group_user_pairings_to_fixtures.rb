class RenameGroupUserPairingsToFixtures < ActiveRecord::Migration
  def change
    rename_table :group_user_pairings, :fixtures
  end
end
