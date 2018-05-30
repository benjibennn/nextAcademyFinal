class SessionsController < ApplicationController
  def new
  end

  def create
	# user = User.find_by(email: params[:session][:email].downcase)
 #    if user && user.authenticate(params[:session][:password])
 #    	cookies[:email] = params[:session][:email]
 #    	flash[:success] = 'Logged In'
 #    	redirect_to '/homes'
 #    else
 #    	flash[:danger] = 'Invalid email/password combination'
 #  		render 'new'
 #  	end

 if request.env['omniauth.auth']
    @user = User.create_with_omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id    
    redirect_to user_path(user.id)
  else
    @user = User.find_by_email(params[:session][:email])
    @user && @user.authenticate(params[:session][:password])
    session[:user_id] = @user.id
    redirect_to '/'

  end
  end

  def destroy
  	session.clear
  	redirect_to '/'
  end
end
