get '/user/signin' do
  erb :sign_in
end

post '/signin' do
  @user = User.authenticate(params[:email], params[:password])
  if @user
    session[:user_id] = @user.id
    redirect '/user/home'
  else
    session[:error] = "Invalid email or password."
    redirect '/'
  end
end

get '/sign_out' do
  session.clear
  redirect '/'
end

post '/sign_up' do
  @user = User.new params[:user]
  if @user.save
    session[:user_id] = @user.id
    redirect '/user/home'
  else
    session[:error] = "Oops, something went wrong! Please try again"
    redirect '/'
  end
end

get '/user/home' do
  if logged_in?
    erb :user_home
  else
    redirect '/'
  end
end
