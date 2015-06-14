class RenameGroupUserPairingInMatches < ActiveRecord::Migration
  def change
    rename_column :matches, :group_user_pairing_id, :fixture_id
  end
end
