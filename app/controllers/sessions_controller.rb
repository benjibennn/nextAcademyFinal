class SessionsController < ApplicationController
  def new
  end

  def create
	user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    	cookies[:email] = params[:session][:email]
    	flash[:success] = 'Logged In'
    	redirect_to '/homes'
    else
    	flash[:danger] = 'Invalid email/password combination'
  		render 'new'
  end
  end

  def destroy
  	cookies.clear
  	redirect_to '/'
  end
end
