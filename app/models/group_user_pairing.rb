class GroupUserPairing < ActiveRecord::Base

  belongs_to :group

  has_many :matches
  has_many :group_users

  def player_one
    GroupUser.find(group_user_one).user
  end

  def player_two
    GroupUser.find(group_user_two).user
  end

  def display
    "#{player_one.name} vs #{player_two.name}"
  end

  def matches_count
    matches.count
  end

  def player_one_goals
    goals(player_one).flatten.sum
  end

  def player_two_goals
    goals(player_two).flatten.sum
  end

  def goals(player)
    matches.map{|m| m.player_goals(player)}
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
