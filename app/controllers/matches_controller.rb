class MatchesController < ApplicationController

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(group: Group.find(params[:group_id]))
    if @match.save
      @match.add_a_player(User.find(params[:user_one]))
      @match.add_a_player(User.find(params[:user_two]))
      redirect_to group_path(params[:group_id])
    end
  end

  # private

  # def match_params
  #   params.permit(:group_id, :user_one, :user_two)
  # end

end
