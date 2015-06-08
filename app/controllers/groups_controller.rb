class GroupsController < ApplicationController

  def show
    @group = Group.find(params[:id])
    @owner = User.find(@group.user_id)
    @members = @group.members_not_including_owner
  end

  def edit
    @group = Group.find(params[:id])
    @users = User.all
  end

  def update
    @group = Group.find(params[:id])
    @new_member = User.find(params[:group][:user_id])
    @group.add_member_to_group(@new_member)
    redirect_to group_path(@group)
  end

end
