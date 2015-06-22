class Fixture < ActiveRecord::Base

  belongs_to :group
  # has_many :group_users, through: :fixture_group_users
  has_many :fixture_group_users
  has_many :matches

  def player_one
    fixture_group_users[0]
  end

  def player_two
    fixture_group_users[1]
  end

  def display
    if suspended_on
      "#{player_one.group_user.name} vs #{player_two.group_user.name} (SUS)"
    else
      "#{player_one.group_user.name} vs #{player_two.group_user.name}"
    end
  end

  def matches_count
    matches.count
  end

  def player_one_goals
    player_one.amount_of_goals_scored
  end

  def player_two_goals
    player_two.amount_of_goals_scored
  end

  def total_goals
    player_one_goals + player_two_goals
  end

  def goals_per_game
    # (total_goals / matches_count).round(2) if matches_count>0
  end

  def player_one_goals_per_game
    # ( player_one_goals / matches_count )
  end

  def player_two_goals_per_game
    # ( player_two_goals / matches_count )
  end

  def draws
    matches.select{ |m| m.draw? }.count
  end

  def bore_draws
    matches.select{|m| m.bore_draw?}.count
  end

  def player_one_wins
    matches.select{|m| m.goal_difference > 0}.count
  end

  def player_two_wins
    matches.select{|m| m.goal_difference < 0}.count
  end

  def player_one_big_wins
    matches.select{|m| m.goal_difference > 2}.count
  end

  def player_two_big_wins
    matches.select{|m| m.goal_difference < -2}.count
  end

  def player_one_clean_sheets
    player_one.amount_of_clean_sheets
  end

  def player_two_clean_sheets
    player_two.amount_of_clean_sheets
  end

  def display_suspended_on
    suspended_on.strftime("%-d %B %Y")
  end
end
