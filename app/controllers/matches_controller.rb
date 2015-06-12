class MatchesController < ApplicationController

  def new
    @match = Match.new
    @group = Group.find(params[:group_id])
    @pairings = @group.group_user_pairings
  end

  def create
    @goals = [params[:user_one_goals], params[:user_two_goals]]
    @pairing = GroupUserPairing.find(params[:group_user_pairing])
    @group = Group.find(params[:group_id])
    @match = Match.new(group: @group, group_user_pairing: @pairing)
    if @match.save
      @match.add_players_and_goals(@pairing, @goals)
      redirect_to group_matches_path(@group)
    end
  end

  def index
    @group = Group.find(params[:group_id])
    @matches = Match.where(group: @group)
    @pairings = @group.group_user_pairings
  end

  # private

  # def match_params
  #   params.permit(:group_id, :user_one, :user_two)
  # end

end
