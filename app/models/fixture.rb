class Fixture < ActiveRecord::Base

  belongs_to :group
  has_many :group_users, through: :fixture_group_users
  has_many :fixture_group_users
  has_many :matches

  def player_one
    group_users[0].user
  end

  def player_two
    group_users[1].user
  end

  def display
    "#{player_one.name} vs #{player_two.name}"
  end

  def matches_count
    matches.count
  end

  def player_one_goals
    matches.map{|m| m.player_one_goals}.sum
  end

  def player_two_goals
    matches.map{|m| m.player_two_goals}.sum
  end

  def player_one_big_wins
    matches.select{|m| m.goal_difference > 2}.count
  end

  def player_two_big_wins
    matches.select{|m| m.goal_difference < -2}.count
  end

  def draws
    matches.select{|m| m.draw?}.count
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

end
