class MatchesController < ApplicationController

  def new
    @match = Match.new
  end

  def create
    @goals = [params[:user_one_goals], params[:user_two_goals]]
    @pairing = GroupUserPairing.find(params[:group_user_pairing])
    @match = Match.new(group: Group.find(params[:group_id]), group_user_pairing: @pairing)
    if @match.save
      @match.add_players_and_goals(@pairing, @goals)
      redirect_to group_path(params[:group_id])
    end
  end

  # private

  # def match_params
  #   params.permit(:group_id, :user_one, :user_two)
  # end

end
