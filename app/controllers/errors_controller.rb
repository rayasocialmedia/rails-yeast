class ErrorsController < ApplicationController
  layout 'errors'
  
  def access_denied
    respond_to do |format|
      format.html do
        if !user_signed_in?
          redirect_to new_user_session_url, :alert => t('errors.login_to_access')
        end
      end
      format.js do
        if user_signed_in?
          @url = access_denied_errors_url
        else
          @url = new_user_session_url
        end
      end
    end
  end
  
  def not_found
  end
  
  def bad_request
  end
end
