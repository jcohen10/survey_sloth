get '/' do
  display_errors
  p session
  @user = User.find_by_id(session[:user_id])
  erb :index
end

get '/user/sign_in' do
  erb :sign_in
end

post '/sign_in' do
  p params
  @user = User.authenticate(params[:email], params[:password])
  if @user
    session[:user_id] = @user.id
    redirect '/'
    # change redirect as needed
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
  p params
  @user = User.new params[:user]
  if @user.save
    session[:user_id] = @user.id
    redirect '/'
    # change redirect as needed
  else
    session[:error] = "Oops, something went wrong! Please try again"
    redirect '/'
  end
end

get '/survey/new' do
  @user_id = session[:user_id]
  erb :new_survey
end

post "/survey/new" do
  survey = Survey.create(creator_id: session[:user_id], title: params["title"])
  question = Question.create(survey_id: survey.id, content: params["question"])
  num_qs = params.length - 1
  count = 1
  num_qs.times do
    PossibleChoice.create(question_id: question.id, content: params["choice #{count}"])
    count += 1
  end
  redirect '/'
end

get '/survey/:survey_id' do
  @survey = Survey.find(params[:survey_id])
  erb :survey_page
end

# not_found do
#   status 404
#   erb :oops
# end


# get '/user/home' do
#   @current_user = User.find(session[:user_id])
#   @user_proficiencies = @current_user.proficiencies
#   erb :index
# end
