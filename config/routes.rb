TheBeardedWanderer::Application.routes.draw do
  resources :users, :except => [ :new, :edit ], defaults: {format: :json}
  
  # get 'home' => 'site#home'
  post '/login' => 'site#login'
  get '/logout' => 'site#logout'

  put 'events/nomz' => 'events#nomz'
  get 'events/meetup_api' => 'events#meetup_api', defaults: { format: :json }
  resources :events


  root :to => 'site#index'
  

end
