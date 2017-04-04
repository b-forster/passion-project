# Show login form

get '/sessions/new' do
  erb :'sessions/new'
end

# Log in

post '/sessions' do
  @user = User.find_by(email: params[:email])
  if @user && @user.password == params[:password]  <- or write user_authenticate method
    session[:id] = @user.id
    redirect "/users/#{@user.id}"
  else
    @errors = ["The email/password combination is invalid."]
  end
end

# Log out

delete '/sessions/:id' do
  logout
  redirect '/'
end