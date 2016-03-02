class SubscribersController < ApplicationController

  def create
    Subscriber.create(subscriber_params)
    redirect_to articles_path
  end

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end

end
