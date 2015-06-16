class RemoveFixtureGroupUserFromMatchPlayers < ActiveRecord::Migration
  def change
    remove_column :match_players, :fixture_group_user_id, :integer
  end
end
