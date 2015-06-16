class MatchPlayer < ActiveRecord::Base
  belongs_to :match
  belongs_to :fixture_group_user

  validates_presence_of :goals

  def self.add_to_match(match, fixture_group_user, goals)
    match.match_players.build do |mp|
        mp.fixture_group_user = fixture_group_user
        mp.goals = goals
    end.save
  end

end
