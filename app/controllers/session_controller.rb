class SessionController < ApplicationController

  def create
    session[:return_to] ||= request.referer
    if (params["email"] == secrets.blogger_email) && (params["password"] == secrets.blogger_password)
      session[:user_signed_in] = true
    end
    redirect_to session.delete(:return_to)
  end

  def secrets
    Rails.application.secrets
  end
end
