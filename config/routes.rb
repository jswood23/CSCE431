Rails.application.routes.draw do
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
  match '/attend', to: 'internal#attend', :via => :all
  match '/members', to: 'internal#members', :via => :all
  match '/profile', to: 'internal#profile', :via => :all
  
  # admin page routes
  match '/manage_members', to: 'admin#manage_members', :via => :all
  match '/manage_pages', to: 'admin#manage_pages', :via => :all
  match '/manage_events', to: 'admin#manage_events', :via => :all

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
