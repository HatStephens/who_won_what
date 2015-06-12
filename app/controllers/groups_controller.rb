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
    @owner = @group.user
    @other_members = @group.members_not_including_owner
  end

  # Adding users needs to be thought out
  def edit
    @group = Group.find(params[:id])
    @users = User.all
    @users_to_add = []
    @users.each do |user|
      @users_to_add << user unless (user.groups.include?(@group) || user.group_users.select{|gu| gu.group == @group}.present?)
    end
  end

  def update
    @group = Group.find(params[:id])
    @new_member = User.find(params[:group][:user_id])
    @group.add_member_to_group(@new_member)
    redirect_to group_path(@group)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.group_users.each do |gu|
      @group.remove_member_from_group(gu)
    end
    @group.deleted_on = Date.today
    redirect_to dashboard_path if @group.save
  end

  private
  def group_params
    params.require(:group).permit(:name, :user)
  end

end
