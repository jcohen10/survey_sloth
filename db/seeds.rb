require 'faker'

10.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    username: Faker::Internet.user_name,
    email: Faker::Internet.email,
    password: "password"
    )
end

user_range = [*1..User.all.length]

10.times do
  Survey.create(title: Faker::Lorem.sentences(3), creator_id: user_range.sample)
end

survey_range = [*1..Survey.all.length]

50.times do
  Question.create(content: Faker::Lorem.sentences(3), survey_id: survey_range.sample)
end

question_range = [*1..Question.all.length]

10.times do
  PossibleChoice.create(content: Faker::Lorem.sentences(3), question_id: question_range.sample)
end

choice_range = [*1..PossibleChoice.all.length]

10.times do
  CompletedSurvey.create(user_id: user_range.sample, survey_id: survey_range.sample)
end

50.times do
  Answer.create(user_id: user_range.sample, possible_choice_id: choice_range.sample)
end
