Rails.application.routes.draw do
  root 'homepage#index'
  get '/feeds' => 'feeds#index'
  post '/users' => 'users#create'
  post '/sessions' => 'sessions#create'
  get '/authenticated' => 'sessions#authenticated'
  delete '/sessions' => 'sessions#destroy'
  post '/tweets' => 'tweets#create'
  delete '/tweets/:id' => 'tweets#destroy'
  get '/tweets' => 'tweets#index'
  get '/users/:username/tweets' => 'tweets#index_by_user'

  # USERS

  # SESSIONS

  # TWEETS

  # Redirect all other paths to index page, which will be taken over by AngularJS
  get '*path' => 'homepage#index'
end
