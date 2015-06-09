class MatchesController < ApplicationController

  def new
    @match = Match.new
  end

  def create
    unless params[:user_one] == params[:user_two]
      @match = Match.new(group: Group.find(params[:group_id]))
      if @match.save
        @match.add_a_player(User.find(params[:user_one]), params[:user_one_goals])
        @match.add_a_player(User.find(params[:user_two]), params[:user_two_goals])
        redirect_to group_path(params[:group_id])
      end
    else
      flash[:alert] = "Players cannot be the same!"
      redirect_to(:back)
    end
  end

  # private

  # def match_params
  #   params.permit(:group_id, :user_one, :user_two)
  # end

end
