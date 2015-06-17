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
    @owner = @group.owner
    @other_members = @group.members_not_including_owner
  end

  # Adding users needs to be thought out more
  def edit
    @group = Group.find(params[:id])
    @users = User.all
    @users_to_add = []
    @users.each do |user|
      @users_to_add << user unless (user.groups.include?(@group) || user.group_users.select{|gu| gu.group == @group}.present?)
    end
    @users_to_remove = @group.users.reject{ |u| u == current_user }
  end

  def update
    @group = Group.find(params[:id])
    if params[:update_type] == 'add'
      @new_member = User.find(params[:group][:user_id])
      @group.add_member_to_group(@new_member)
      flash[:alert] = "#{@new_member.name} has been added to this group."
    elsif params[:update_type] == 'remove'
      @member_to_remove = User.find(params[:group][:user_id])
      @group.remove_member_from_group(@member_to_remove)
      flash[:alert] = "#{@member_to_remove.name} has been removed from this group."
    else
      flash[:alert] = "Error somewhere!"
    end
    redirect_to group_path(@group)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.group_users.each do |gu|
      @group.remove_member_from_group(gu)
    end
    @group.deleted_on = Date.today     # should I update attribute in model instead?
    redirect_to dashboard_path if @group.save
  end

  private
  def group_params
    params.require(:group).permit(:name, :user)
  end

end
