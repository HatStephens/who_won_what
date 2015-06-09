class AddGoalsToMatchPlayers < ActiveRecord::Migration
  def change
    add_column :match_players, :goals, :integer
  end
end
