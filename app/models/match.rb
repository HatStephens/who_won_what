class Match < ActiveRecord::Base

  belongs_to :group
  belongs_to :group_user_pairing

  has_many :match_players, dependent: :destroy

  def add_players_and_goals(pairing, goals)
    MatchPlayer.add_to_match(self, pairing.player_one, goals.first)
    MatchPlayer.add_to_match(self, pairing.player_two, goals.last)
  end

  def player_goals(user)
    MatchPlayer.where(match: self, user: user).first.goals
  end

  def goal_difference
    player_goals(self.match_players[0].user) - player_goals(self.match_players[1].user)
  end

  def draw?
    goal_difference == 0
  end

  def bore_draw?
    player_goals(player_one) == 0 && player_goals(player_two) == 0
  end

  def player_one
    match_players[0].user
  end

  def player_two
    match_players[1].user
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

  # def between_a(pairing)
  #   @first_check = self.match_players.select{|mp| mp.user == pairing.player_one}
  #   if @first_check.empty?
  #     return
  #   else
  #     @second_check = self.match_players.select{|mp| mp.user == pairing.player_two}
  #   end
  #   @second_check.empty? ? nil : self
  # end
end
