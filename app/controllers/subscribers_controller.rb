class SubscribersController < ApplicationController

  def create
    session[:return_to] ||= request.referer
    subscriber = Subscriber.new(subscriber_params)
    flash[:error] = subscriber.errors.full_messages.to_sentence if !subscriber.save
    redirect_to session.delete(:return_to)
  end

  def destroy
    sub = Subscriber.find(params[:id])
    sub.destroy
    redirect_to articles_path
  end

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end

end
