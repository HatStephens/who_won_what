class Group < ActiveRecord::Base

  belongs_to :user

  default_scope { where(deleted_on: nil) }

  has_many :users, through: :group_users
  has_many :group_users
  has_many :matches
  has_many :fixtures


  validates_presence_of :user

  after_save :add_owner_to_group

  def add_owner_to_group
    GroupUser.add_user_to_group(user, self)
  end

  def add_member_to_group(new_member)
    GroupUser.add_user_to_group(new_member, self)
    create_fixtures_for(group_users.last)
  end

  def remove_member_from_group(member)
    @group_user = GroupUser.find_by(user: member.user, group: self)
    @group_user.destroy
  end

  def create_fixtures_for(group_user)
    group_users.each do |gu|
      unless(gu == group_user)
       new_fixture = self.fixtures.build(group: self)
       new_fixture.save
       add_group_users_to_fixture(group_user, gu, new_fixture)
      end
    end
  end

  def add_group_users_to_fixture(group_user_one, group_user_two, fixture)
    fixture.fixture_group_users.build(group_user: group_user_one).save
    fixture.fixture_group_users.build(group_user: group_user_two).save
  end

  def members_not_including_owner
    users.reject{|u| u == user }
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
