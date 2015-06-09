class MatchPlayer < ActiveRecord::Base
  belongs_to :match
  belongs_to :user

  validates_presence_of :goals

  def self.add_to_match(match, user, goals)
    match.match_players.build do |mp|
        mp.user = user
        mp.goals = goals
    end.save
  end

end
