class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groups
  has_many :group_users

  def name
    nickname ? nickname : "#{first_name} #{last_name}"
  end

  def all_groups
    group_users.map(&:group)
  end

  def all_active_groups
    all_groups.reject(&:nil?)
  end

end
