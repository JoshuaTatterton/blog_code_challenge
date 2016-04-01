class SessionController < ApplicationController

  def create
    session[:return_to] ||= request.referer

    if (params["email"] == secrets.blogger_email) && (params["password"] == secrets.blogger_password)
      session[:user_signed_in] = true
    else
      flash[:error] = "Wrong email or password, only try to sign in if your write the blog."
    end

    redirect_to session.delete(:return_to)
  end

  private

  def secrets
    Rails.application.secrets
  end
end
