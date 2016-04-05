class SubscribersController < ApplicationController
  
  def create
    blogger = Blogger.find(params[:blogger_id])
    subscriber = blogger.subscribers.new(subscriber_params)

    flash[:error] = subscriber.errors.full_messages.to_sentence if !subscriber.save
    
    redirect_to :back
  end

  def destroy
    Subscriber.find(params[:id]).destroy

    redirect_to blogger_articles_path(Blogger.find(params[:blogger_id]))
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end

end
