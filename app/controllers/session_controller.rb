class SessionController < ApplicationController

  def create
    if (params["email"] == secrets.blogger_email) && (params["password"] == secrets.blogger_password)
      session[:user_signed_in] = true
    else
      flash[:error] = "Wrong email or password, only try to sign in if your write the blog."
    end

    redirect_to :back
  end

  private

  def secrets
    Rails.application.secrets
  end
end
