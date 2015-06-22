class FixtureGroupUser < ActiveRecord::Base
  belongs_to :fixture
  belongs_to :group_user

  has_many :matches, through: :match_players
  has_many :match_players

  def player_one?
    self == fixture.player_one
  end

  def amount_of_matches
    matches.count
  end

  def amount_of_goals_scored
    player_one? ? matches.map{ |m| m.player_one_goals }.sum : matches.map{ |m| m.player_two_goals }.sum
  end

  def amount_of_goals_conceded
    player_one? ? matches.map{ |m| m.player_two_goals }.sum : matches.map{ |m| m.player_one_goals }.sum
  end

  def amount_of_wins
    player_one? ? matches.select{ |m| m.goal_difference > 0 }.count : matches.select{ |m| m.goal_difference < 0 }.count
  end

  def amount_of_draws
    matches.select{ |m| m.draw? }.count
  end

  def amount_of_losses
    player_one? ? matches.select{ |m| m.goal_difference < 0 }.count : matches.select{ |m| m.goal_difference > 0 }.count
  end

  def amount_of_big_wins
    player_one? ? matches.select{ |m| m.player_one_big_wins? }.count : matches.select{ |m| m.player_two_big_wins? }.count
  end

  def amount_of_big_losses
    player_one? ? matches.select{ |m| m.player_two_big_wins? }.count : matches.select{ |m| m.player_one_big_wins? }.count
  end

  def amount_of_bore_draws
    matches.select{ |m| m.bore_draw? }.count
  end

  def amount_of_clean_sheets
    player_one? ? matches.select{ |m| m.player_one_clean_sheet? }.count : matches.select{ |m| m.player_two_clean_sheet? }.count
  end
end
