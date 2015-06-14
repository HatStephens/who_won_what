class FixtureGroupUser < ActiveRecord::Base
  belongs_to :fixture
  belongs_to :group_user
end
