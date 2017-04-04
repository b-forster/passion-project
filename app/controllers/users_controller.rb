get '/users' do
  @users = User.all
end

get '/users/new' do
  erb :'users/new'
end

post '/users' do
  if params[:user][:password] != params[:password_confirmation]
    @errors = ['Passwords must match.']
    erb :'users/new'
  else
    @user = User.new(params[:user])
    if @user.save
     session[:id] = @user.id
     redirect "/users/#{@user.id}"
    else
      @errors = @user.errors.full_messages
      erb :'users/new'
    end
  end
end

get '/users/:id' do
  # Allow logged in users to view all users' profiles
  redirect '/' unless logged_in?

  @user = User.find(params[:id])
  erb :'users/show'
end

