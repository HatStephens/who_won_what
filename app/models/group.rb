class Group < ActiveRecord::Base
  belongs_to :user

  has_many :group_users
  has_many :users, through: :group_users

  before_create :add_owner_to_group

  def add_owner_to_group
    GroupUser.add_user_to_group(user, self)
  end

  def add_member_to_group(user)
    GroupUser.add_user_to_group(user, self)
  end

  def members_not_including_owner
    users.reject{|gu| gu.id == user.id }
  end
end
