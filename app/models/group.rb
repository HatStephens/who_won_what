class Group < ActiveRecord::Base
  belongs_to :user

  has_many :group_users

  before_create :add_owner_to_group

  def add_owner_to_group
    GroupUser.add_user_to_group(user, self)
  end
end
