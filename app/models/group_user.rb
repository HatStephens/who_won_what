class GroupUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  # has_many :fixtures, through: :fixture_group_users
  has_many :fixture_group_users
  # has_many :matches, through: :match_players
  # has_many :match_players

  def self.add_user_to_group(user, group)
    group.group_users.build do |gu|
      gu.user = user
    end.save
  end

  def name
    user.name
  end

  def total_matches
    fixture_group_users.map{ |fgu| fgu.amount_of_matches }.sum
  end

  def total_goals_scored
    fixture_group_users.map{ |fgu| fgu.amount_of_goals_scored }.sum
  end

  def total_goals_conceded
    fixture_group_users.map{ |fgu| fgu.amount_of_goals_conceded }.sum
  end

  def total_matches_won
    fixture_group_users.select{ |fgu| fgu.amount_of_wins }.count
  end

  def total_matches_lost
    fixture_group_users.select{ |fgu| fgu.amount_of_losses }.count
  end

  def total_matches_drawn
    fixture_group_users.select{ |fgu| fgu.amount_of_draws }.count
  end

  def total_big_wins
    fixture_group_users.select{ |fgu| fgu.amount_of_big_wins }.count
  end

  def total_big_losses
    fixture_group_users.select{ |fgu| fgu.amount_of_losses }.count
  end

  def total_bore_draws
    fixture_group_users.select{ |fgu| fgu.amount_of_bore_draws }.count
  end

  def total_clean_sheets
    fixture_group_users.select{ |fgu| fgu.amount_of_clean_sheets }.count
  end

end
