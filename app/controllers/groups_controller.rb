class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    redirect_to dashboard_path if @group.save
  end

  def show
    @group = Group.find(params[:id])
    @owner = User.find(@group.user_id)
    @members = @group.members_not_including_owner
  end

  def edit
    @group = Group.find(params[:id])
    @users_to_add = []
    @group.members_not_including_owner.each do |member|
      @users_to_add << member.user unless member.user.group_users.group(@group)
    end
  end

  def update
    @group = Group.find(params[:id])
    @new_member = User.find(params[:group][:user_id])
    @group.add_member_to_group(@new_member)
    redirect_to group_path(@group)
  end

  private
  def group_params
    params.require(:group).permit(:name, :user)
  end

end
