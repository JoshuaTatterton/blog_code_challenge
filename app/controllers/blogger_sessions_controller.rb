class BloggerSessionsController < ApplicationController

  def create
    if @blogger = login(params[:email], params[:password])
      flash.now[:alert] = 'Login Successful'
      redirect_to blogger_articles_path(current_user)
    else
      flash.now[:alert] = 'Login failed'
      redirect_to 
    end
  end

  def destroy
  end
end
