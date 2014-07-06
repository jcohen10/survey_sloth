get '/survey/new' do
  if logged_in?
    erb :new_survey
  else
    redirect '/'
  end
end

post '/survey/new' do
  survey = Survey.create(creator_id: session[:user_id], title: params["title"])
  question = Question.create(survey_id: survey.id, content: params["question"])
  num_qs = params.length - 2
  count = 1
  num_qs.times do
    PossibleChoice.create(question_id: question.id, content: params["choice #{count}"])
    count += 1
  end
  redirect '/user/home'
end

get '/survey/all' do
  @surveys = Survey.all
  erb :all_surveys
end

get '/survey/:survey_id' do
  @survey = Survey.find(params[:survey_id])
  erb :survey_page
end

post '/survey/:survey_id' do
  choice = PossibleChoice.find(params["answer"])
  choice.increment!(:times_chosen)
  Answer.new(user_id: session[:user_id], possible_choice: choice)
  redirect '/user/home'
end

get '/survey/:survey_id/edit' do
  if logged_in?
    @survey = Survey.find(params[:survey_id])
    erb :edit_survey
  else
    redirect '/'
  end
end

put '/survey/:survey_id' do
  @survey = Survey.find(params[:survey_id])
  @survey.update_attributes(title: params[:title])
  redirect "/survey/#{@survey.id}"
end

get '/survey/all/user/:user_id' do
  if logged_in?
    @surveys = @user.surveys
    erb :user_surveys
  else
    redirect '/'
  end
end

get '/survey/results/:survey_id' do
  if logged_in?
    session[:survey_id] = params[:survey_id]
    @survey = Survey.find(params[:survey_id])
    @question = Question.where(survey_id: @survey.id).last
    @possiblechoices = PossibleChoice.where(question_id: @question.id)
    erb :survey_stats
  else
    redirect '/'
  end
end

post '/survey/results/stats/' do
  @survey = Survey.find(session[:survey_id])
  @question = Question.where(survey_id: @survey.id).last
  @possiblechoices = PossibleChoice.where(question_id: @question.id)

  {:response => @possiblechoices}.to_json

end
