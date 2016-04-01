class SubscribersController < ApplicationController

  def create
    subscriber = Subscriber.new(subscriber_params)

    flash[:error] = subscriber.errors.full_messages.to_sentence if !subscriber.save
    
    redirect_to :back
  end

  def destroy
    sub = Subscriber.find(params[:id])
    
    sub.destroy

    redirect_to articles_path
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end

end
