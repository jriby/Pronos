class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

 def validate_passwd?(passwd,validate_passwd)
   passwd == validate_passwd
 end
  def user_exist
    redirect_to(users_path) unless User.exist?(params[:user_id]) || User.exist?(params[:id])
  end
end
