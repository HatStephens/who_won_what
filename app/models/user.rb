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

  def total_matches
    group_users.map{ |gu| gu.total_matches }.sum
  end

  def total_goals_scored
    group_users.map{ |gu| gu.total_goals_scored }.sum
  end

  def total_goals_conceded
    group_users.map{ |gu| gu.total_goals_conceded }.sum
  end

  def total_matches_won
    group_users.map{ |gu| gu.total_matches_won }.sum
  end

  def total_matches_lost
    group_users.map{ |gu| gu.total_matches_lost }.sum
  end

  def total_matches_drawn
    group_users.map{ |gu| gu.total_matches_drawn }.sum
  end

  def total_big_wins
    group_users.map{ |gu| gu.total_big_wins }.sum
  end

  def total_big_losses
    group_users.map{ |gu| gu.total_big_losses }.sum
  end

  def total_bore_draws
    group_users.map{ |gu| gu.total_bore_draws }.sum
  end

  def total_clean_sheets
    group_users.map{ |gu| gu.total_clean_sheets }.sum
  end

end
