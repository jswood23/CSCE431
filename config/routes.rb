Rails.application.routes.draw do
  resources :pages
  resources :events
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # root route at external/home
  root 'external#home'

  get '/users/auth/:provider/callback' => 'sessions#create'
  get '/users/auth/failure', to: redirect('/users/sign_in')
  get '/users', to: redirect('/users/sign_up')

  # external page routes
  get '/about', to: 'external#about'
  get '/contact', to: 'external#contact'
  get '/view_events', to: 'external#events'
  get '/home', to: 'external#home'

  # internal page routes
  match '/attend', to: 'internal#attend', :via => :all
  match '/members', to: 'internal#members', :via => :all
  match '/profile', to: 'internal#profile', :via => :all
  match '/internal_contact', to: 'internal#internal_contact', :via => :all

  # internal actions
  post 'attend_event', to: 'events#attend_event'
  
  # admin page routes
  get '/manage_members', to: 'admin#manage_members'
  get '/manage_pages', to: 'admin#manage_pages'
  get '/update_points', to: 'admin#update_points_page'

  # admin actions
  get '/make_user_admin/:userid', to: 'admin#make_user_admin'
  get '/make_user_member/:userid', to: 'admin#make_user_member'
  get '/make_user_alumni/:userid', to: 'admin#make_user_alumni'
  get '/remove_user_member/:userid', to: 'admin#remove_user_member'
  get '/show_user_attendance/:userid', to: 'admin#show_user_attendance'
  get '/delete_user/:userid', to: 'admin#delete_user'
  get '/remove_points_type/:points_type_id', to: 'admin#remove_points_type'
  post '/show_user_attendance/change_user_points', to: 'admin#change_user_points'
  post '/change_points_type', to: 'admin#change_points_type'

  get '/events/show_attendance/:event_id', to: 'events#show_attendance'
  get '/events/remove_from_attendance/:event_id/:uid', to: 'events#remove_from_attendance'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
