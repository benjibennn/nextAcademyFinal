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

 def create_from_omniauth
  auth_hash = request.env["omniauth.auth"]
  authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

  # if: previously already logged in with OAuth
  if authentication.user
    user = authentication.user
    authentication.update_token(auth_hash)
    @next = root_url
    @notice = "Signed in!"
  # else: user logs in with OAuth for the first time
  else
    user = User.create_with_auth_and_hash(authentication, auth_hash)
    # you are expected to have a path that leads to a page for editing user details
    @next = edit_user_path(user)
    @notice = "User created. Please confirm or edit details"
  end

  sign_in(user)
  redirect_to @next, :notice => @notice
end

def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s
  end

  def callback
  client = Signet::OAuth2::Client.new({
    client_id: ENV['GOOGLE_APP_ID'],
    client_secret: ENV['GOOGLE_APP_SECRET'],
    token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
    redirect_uri: url_for(:action => :callback),
    code: params[:code]
  })

  response = client.fetch_access_token!

  session[:access_token] = response['access_token']

  redirect_to url_for(:action => :calendars)
end

def calendars
  client = Signet::OAuth2::Client.new(access_token: session[:access_token])

  service = Google::Apis::CalendarV3::CalendarService.new

  service.authorization = client

  @calendar_list = service.list_calendar_lists
end

  private

  def client_options
    {
      client_id: Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: callback_url
    }
  end

end
