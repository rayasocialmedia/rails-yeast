class ApplicationController < ActionController::Base
  protect_from_forgery
  # layout :layout_by_resource
  before_filter :set_locale
 
  def set_locale
    # Default to configured default locale if no passed locale parameter
    I18n.locale = params[:locale] || I18n.default_locale
    # I18n.locale = I18n.default_locale
    unless params[:locale].nil?
      # Passed locale in parameters overrides default
      I18n.locale = params[:locale]
    end
    if user_signed_in? && defined? current_user.locale
      I18n.locale = current_user.locale
    end
  end

  protected

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => :render_error
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from ActionController::RoutingError, :with => :render_not_found
    rescue_from ActionController::UnknownController, :with => :render_not_found
    rescue_from ActionController::UnknownAction, :with => :render_not_found
    rescue_from CanCan::AccessDenied do |exception|
      session['user_return_to'] = request.url
      redirect_to access_denied_errors_url, :alert => exception.message
    end
  end
  
end
