class GroupUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  has_many :fixtures, through: :fixture_group_users
  has_many :fixture_group_users

  def self.add_user_to_group(user, group)
    group.group_users.build do |gu|
      gu.user = user
    end.save
  end

  def total_matches
    fixtures.map{|f| f.matches_count}.sum
  end

  def total_goals
    # here
  end

end
