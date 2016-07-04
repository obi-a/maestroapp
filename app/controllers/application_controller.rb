class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :alert, :info
  before_action {
    @current_page = if params[:controller] == "devise/registrations"
      :signup
    elsif params[:controller] == "devise/sessions"
      :signin
    end
  }
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
     session[:guest_user_id] = nil
     guest_user if with_retry
  end

  private

  def create_guest_user
    u = User.create(email: "guest_#{Time.now.to_i}#{rand(100)}@southmunn.com")
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end

  def configure_devise_permitted_parameters
    registration_params = [:email, :firstname, :lastname, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) {
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) {
        |u| u.permit(registration_params)
      }
    end
  end
end
