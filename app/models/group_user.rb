class GroupUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  def self.add_user_to_group(user, group)
    group.group_users.build do |gu|
      gu.user = user
    end.save
  end

  def name
    user.name
  end

end
