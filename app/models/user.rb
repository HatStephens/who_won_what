class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groups
  has_many :groups, through: :group_users
  has_many :group_users
  # has_many :match_players

  def name
    (nickname == "") ? "#{first_name} #{last_name}" : nickname
  end

end
