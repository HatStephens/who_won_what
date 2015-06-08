class Match < ActiveRecord::Base

  belongs_to :group

  has_many :match_players
  # has_one :match_data

  def add_a_player(user)
    MatchPlayer.add_to_match(self, user)
  end

end
