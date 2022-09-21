Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # root route at external/home
  root 'external#home'

  # internal page routes
  get '/attend', to: 'internal#attend'
  get '/members', to: 'internal#members'
  get '/profile', to: 'internal#profile'

  # external page routes
  get '/about', to: 'external#about'
  get '/contact', to: 'external#contact'
  get '/events', to: 'external#events'
  get '/home', to: 'external#home'
  get '/login', to: 'external#login'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
