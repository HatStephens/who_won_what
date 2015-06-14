class MatchesController < ApplicationController

  def new
    @match = Match.new
    @group = Group.find(params[:group_id])
    @fixtures = @group.fixtures
  end

  def create
    @goals = [params[:user_one_goals], params[:user_two_goals]]
    @fixture = Fixture.find(params[:fixture])
    @group = Group.find(params[:group_id])
    @match = Match.new(group: @group, fixture: @fixture)
    if @match.save
      @match.add_players_and_goals(@fixture, @goals)
      redirect_to group_matches_path(@group)
    end
  end

  def index
    @group = Group.find(params[:group_id])
    @matches = Match.where(group: @group)
    @fixtures = @group.fixtures
    @group_user = current_group_user(@group)
  end

  # private

  # def match_params
  #   params.permit(:group_id, :user_one, :user_two)
  # end

end
