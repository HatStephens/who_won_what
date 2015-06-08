class MatchPlayer < ActiveRecord::Base
  belongs_to :match
  belongs_to :user

  def self.add_to_match(match, user)
    match.match_players.build do |mp|
        mp.user = user
    end.save
  end

end
