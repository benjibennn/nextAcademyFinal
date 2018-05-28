class UsersController < ApplicationController

  def index
  end

  def new 
    @user = User.new
    # User.create(first_name: params[first_name], last_name: params[last_name], email: params[email], password: params[password])
  end

  def create
    @user = User.create(first_name: params[:user][:first_name], last_name: params[:user][:last_name], email: params[:user][:email], password: params[:user][:password])
    if @user.save
      redirect_to root_path
    else
      redirect_to(:back)
    end
  end

  def login
    @user = User.last

    # cookies[:login] = "ben"
    # cookies[:password] = "123"
  end


  def logout
    cookies.delete :login
    cookies.delete :password
  end

end
