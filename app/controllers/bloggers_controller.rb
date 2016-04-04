class BloggersController < ApplicationController
  def index
    @bloggers = Blogger.all.reverse
  end

  def create
    blogger = Blogger.new(blogger_params)

    if blogger.save
      flash[:success] = "You have signed up"
      auto_login(blogger)
      redirect_to blogger_articles_path(blogger)
    else
      flash[:error] = "Sign up failed"
      redirect_to :back
    end
  end

  private

  def blogger_params
    params.require(:blogger).permit(:email, :password, :password_confirmation, :username)
  end

  def random_blogger
    @blogger = false
  end
end