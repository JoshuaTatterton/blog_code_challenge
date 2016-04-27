class BloggerSessionsController < ApplicationController

  def new
    render layout: "clean"
  end

  def create
    blogger = login(params[:email], params[:password])
    if logged_in?
      flash[:success] = "You have signed in"
      redirect_to blogger_articles_path(current_user)
    else
      flash.now[:error] = "Sign in failed"
      render :new, layout: "clean"
    end
  end

  def destroy
    logout
    if !logged_in?
      flash[:success] = "You have signed out"
      redirect_to :root
    else
      flash[:error] = "Sign out failed"
      redirect_to :back
    end
  end
end
