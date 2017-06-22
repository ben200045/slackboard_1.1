class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :remove_cache_storage

  def after_sign_in_path_for(user)
  	user_groups_path(current_user.id)
  end

  def remove_cache_storage
    #response.headers["Cache-Control"] = "no-cache, no-store, max-age=180, must-revalidate"
    #response.headers["Pragma"] = "no-cache"
  end
  
end
