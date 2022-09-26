Rails.application.routes.draw do
  resources :attendances
  resources :events
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # root route at external/home
  root 'external#home'

  # external page routes
  get '/about', to: 'external#about'
  get '/contact', to: 'external#contact'
  get '/events', to: 'external#events'
  get '/home', to: 'external#home'

  # internal page routes
  get '/attend', to: 'internal#attend'
  get '/members', to: 'internal#members'
  get '/profile', to: 'internal#profile'
  
  # admin page routes
  get '/manage_members', to: 'admin#manage_members'
  get '/manage_pages', to: 'admin#manage_pages'
  get '/manage_events', to: 'admin#manage_events'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
