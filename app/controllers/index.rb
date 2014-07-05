get '/' do
  display_errors
  p session
  @user = User.find_by_id(session[:user_id])
  if !@user
    erb :index
  else
    redirect'/user/home'
  end
end

get '/user/signin' do
  erb :sign_in
end

post '/signin' do
  p params
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

get '/survey/all' do
  @surveys = Survey.all
  erb :all_surveys
end

get '/user/home' do
  p "*"*100
  p session[:user_id]
  @user = User.find(session[:user_id])
  erb :user_home
end

post "/survey/new" do
  survey = Survey.create(creator_id: session[:user_id], title: params["title"])
  question = Question.create(survey_id: survey.id, content: params["question"])
  num_qs = params.length - 2
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

post '/survey/:survey_id' do
  choice = PossibleChoice.find(params["answer"])
  choice.increment!(:times_chosen)
  Answer.new(user_id: session[:user_id], possible_choice: choice)
  redirect '/'
end


get '/survey/results/:survey_id' do

  p params[:survey_id]
  session[:survey_id] = params[:survey_id]
  @survey = Survey.find(params[:survey_id])
  @question = Question.where(survey_id: @survey.id).last
  @possiblechoices = PossibleChoice.where(question_id: @question.id)
  erb :survey_stats
end

post '/survey/results/stats/' do
  p "*"*100
  @survey = Survey.find(session[:survey_id])
  @question = Question.where(survey_id: @survey.id).last
  @possiblechoices = PossibleChoice.where(question_id: @question.id)

  {:response => @possiblechoices}.to_json
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
