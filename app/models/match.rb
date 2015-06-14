class Match < ActiveRecord::Base

  belongs_to :group
  belongs_to :fixture

  has_many :match_players, dependent: :destroy

  def add_players_and_goals(fixture, goals)
    MatchPlayer.add_to_match(self, fixture.player_one, goals.first)
    MatchPlayer.add_to_match(self, fixture.player_two, goals.last)
  end

  def player_goals(user)
    MatchPlayer.where(match: self, user: user).first.goals
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

  def player_one
    match_players[0]
  end

  def player_two
    match_players[1]
  end

  def player_one_goals
    player_one.goals
  end

  def player_two_goals
    player_two.goals
  end

  # def player_one_goals
  #   player_one.goals
  # end

  # def player_two_goals
  #   player_two.goals
  # end

  # def score
  #   "#{player_one_goals} - #{player_two_goals}"
  # end

  # def between_players?(user_one, user_two)
  #   @first_check = self.match_players.select{|mp| mp.user == user_one}
  #   if @first_check.empty?
  #     return
  #   else
  #     @second_check = self.match_players.select{|mp| mp.user == user_two}
  #   end
  #   @second_check.empty? ? nil : self
  # end

  # def between_a(fixture)
  #   @first_check = self.match_players.select{|mp| mp.user == fixture.player_one}
  #   if @first_check.empty?
  #     return
  #   else
  #     @second_check = self.match_players.select{|mp| mp.user == fixture.player_two}
  #   end
  #   @second_check.empty? ? nil : self
  # end
end
