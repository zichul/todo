class SessionsController < ApplicationController
  def new
    redirect_to registration_path if User.count == 0
  end
  
  def create
    if login(params[:email], params[:password], params[:remember_me])
      redirect_back_or_to root_url, notice: I18n.t(:login_successful)
    else
      flash.now.alert = I18n.t(:login_failed)
      render action: :new
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: I18n.t(:logout)
  end
end
