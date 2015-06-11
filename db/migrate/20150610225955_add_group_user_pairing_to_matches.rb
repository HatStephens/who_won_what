class AddGroupUserPairingToMatches < ActiveRecord::Migration
  def change
    add_reference :matches, :group_user_pairing, index: true
    add_foreign_key :matches, :group_user_pairings
  end
end
