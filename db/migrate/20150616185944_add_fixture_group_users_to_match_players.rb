class AddFixtureGroupUsersToMatchPlayers < ActiveRecord::Migration
  def change
    add_reference :match_players, :fixture_group_user, index: true
    add_foreign_key :match_players, :fixture_group_users
  end
end
