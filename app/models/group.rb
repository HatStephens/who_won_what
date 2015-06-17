class Group < ActiveRecord::Base

  belongs_to :user

  default_scope { where(deleted_on: nil) }

  has_many :users, through: :group_users
  has_many :group_users
  has_many :matches, through: :fixtures
  has_many :fixtures


  validates_presence_of :user

  after_save :add_owner_to_group

  def owner
    user
  end

  def add_owner_to_group
    GroupUser.add_user_to_group(user, self)
  end

  def add_member_to_group(new_member)
    GroupUser.add_user_to_group(new_member, self)
    create_fixtures_for(group_users.last)
  end

  def remove_member_from_group(member)
    @group_user = GroupUser.find_by(user: member, group: self)
    @group_user.deleted_on = Date.today
    @group_user.save
    suspend_fixtures_involving(@group_user)
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

  def suspend_fixtures_involving(group_user)
    @fixture_group_users = FixtureGroupUser.where(group_user: group_user)
    @fixtures = []
    @fixture_group_users.each do |fgu|
      @fixtures << Fixture.find(fgu.fixture)
    end
    @fixtures.each do |f|
      f.suspended_on = Date.today
      f.save
    end
  end

  def add_group_users_to_fixture(group_user_one, group_user_two, fixture)
    fixture.fixture_group_users.build(group_user: group_user_one).save
    fixture.fixture_group_users.build(group_user: group_user_two).save
  end

  def members_not_including_owner
    group_users.reject{|gu| gu.user == owner || gu.deleted_on.present? }
  end
end
