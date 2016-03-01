class SessionController < ApplicationController

  def create
    if (params["email"] == secrets.blogger_email) && (params["password"] == secrets.blogger_password)
      session[:user_signed_in] = true
    end
    redirect_to articles_url
  end

  def secrets
    Rails.application.secrets
  end
end
