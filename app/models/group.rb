class Group < ActiveRecord::Base

  belongs_to :user

  has_many :group_users
  has_many :matches

  validates_presence_of :user

  after_save :add_owner_to_group

  def add_owner_to_group
    GroupUser.add_user_to_group(user, self)
  end

  def add_member_to_group(new_member)
    GroupUser.add_user_to_group(new_member, self)
  end

  def members_not_including_owner
    group_users.reject{|gu| gu.user.id == user.id }
  end

  def matches_between_players?(user_one, user_two)
    results = self.matches.map{|m| m.between_players?(user_one, user_two)}
    results.compact
  end

  def goals_for(user_one, user_two)
    @matches = matches_between_players?(user_one, user_two)
    @goals = @matches.map{|m| m.player_goals(user_one)}
    @goals.flatten.sum
  end

  def goals_against(user_one, user_two)
    @matches = matches_between_players?(user_one, user_two)
    @goals = @matches.map{|m| m.player_goals(user_two)}
    @goals.flatten.sum
  end

end
