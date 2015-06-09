class Match < ActiveRecord::Base

  belongs_to :group

  has_many :match_players, dependent: :destroy

  def add_a_player(user, goals)
    MatchPlayer.add_to_match(self, user, goals)
  end

  def player_one
    MatchPlayer.where(match: self).first
  end

  def player_two
    MatchPlayer.where(match: self).last
  end

  def score
    "#{player_one.goals} - #{player_two.goals}"
  end

  def between_players?(user_one, user_two)
    @first_check = self.match_players.select{|mp| mp.user == user_one}
    if @first_check.empty?
      return
    else
      @second_check = self.match_players.select{|mp| mp.user == user_two}
    end
    @second_check.empty? ? nil : self
  end

  def player_goals(user)
    MatchPlayer.where(match: self, user: user).map{|mp| mp.goals}
  end

end
