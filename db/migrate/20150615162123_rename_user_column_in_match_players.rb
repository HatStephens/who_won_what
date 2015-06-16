class RenameUserColumnInMatchPlayers < ActiveRecord::Migration
  def change
    rename_column :match_players, :user_id, :group_user_id
  end
end
