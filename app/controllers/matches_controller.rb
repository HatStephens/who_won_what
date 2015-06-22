class MatchesController < ApplicationController

  def new
    @match = Match.new
    @group = Group.find(params[:group_id])
    @fixtures = @group.fixtures.where(suspended_on: nil)
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
    @matches = @group.matches
    @fixtures = @group.fixtures
    @group_user = current_group_user(@group)
    @last_session_matches = @group.matches.where("matches.created_at >= :start_date AND matches.created_at <= :end_date",
      {start_date: @group.last_session_date, end_date: @group.last_session})
  end

  # private

  # def match_params
  #   params.permit(:group_id, :user_one, :user_two)
  # end

end
