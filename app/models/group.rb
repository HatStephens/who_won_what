class Group < ActiveRecord::Base

  belongs_to :user

  default_scope { where(deleted_on: nil) }

  has_many :group_users
  has_many :matches
  has_many :group_user_pairings


  validates_presence_of :user

  after_save :add_owner_to_group

  def add_owner_to_group
    GroupUser.add_user_to_group(user, self)
  end

  def add_member_to_group(new_member)
    GroupUser.add_user_to_group(new_member, self)
    create_group_user_pairing(group_users.last)
  end

  def remove_member_from_group(member)
    @group_user = GroupUser.find_by(user: member.user, group: self)
    @group_user.destroy
  end

  def create_group_user_pairing(group_user)
    group_users.each do |gu|
      self.group_user_pairings.build(group_user_one: gu.id, group_user_two: group_user.id).save unless gu == group_user
    end
  end

  def members_not_including_owner
    @members = group_users.reject{|gu| gu.user.id == user.id }
    @members.map(&:user)
  end

  # def big_wins(user_one, user_two)
  #   @matches = matches_between_players?(user_one, user_two)
  #   @big_wins = @matches.map{|m| m.check_big_win}
  # end

  # def big_wins_for(user_one, user_two)
  #   @big_wins = big_wins(user_one, user_two)
  #   @big_wins.select{|bw| bw.try(:user) == user_one}.count unless @big_wins.empty?
  # end

  # def big_wins_against(user_one, user_two)
  #   @big_wins = big_wins(user_one, user_two)
  #   @big_wins.select{|bw| bw.try(:user) == user_two}.count unless @big_wins.empty?
  # end

end
