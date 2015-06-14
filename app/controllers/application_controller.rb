class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    return dashboard_path
    super
  end

  def current_group_user(group)
    current_user.group_users.where(group: group).first
  end
end
