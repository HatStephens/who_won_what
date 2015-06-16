class Match < ActiveRecord::Base

  belongs_to :group
  belongs_to :fixture

  has_many :fixture_group_users, through: :match_players
  has_many :match_players, dependent: :destroy

  def add_players_and_goals(fixture, goals)
    MatchPlayer.add_to_match(self, fixture.player_one, goals.first)
    MatchPlayer.add_to_match(self, fixture.player_two, goals.last)
  end

  def player_one
    match_players[0]
  end

  def player_two
    match_players[1]
  end

  def goal_difference
    player_one_goals - player_two_goals
  end

  def draw?
    goal_difference == 0
  end

  def bore_draw?
    player_one_goals == 0 && player_two_goals == 0
  end


  def player_one_goals
    player_one.goals
  end

  def player_two_goals
    player_two.goals
  end

  def player_one_big_win?
    goal_difference > 2
  end

  def player_two_big_win?
    goal_difference < -2
  end

  def amount_of_goals
    player_one_goals + player_two_goals
  end

  def player_one_clean_sheet?
    player_two.goals == 0
  end

  def player_two_clean_sheet?
    player_one.goals == 0
  end
end
