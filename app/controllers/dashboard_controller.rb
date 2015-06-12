class DashboardController < ApplicationController

  def show
    @groups = current_user.all_active_groups
  end

end
