Rails.application.routes.draw do
  # root route at external/home
  root 'external#home'

  # external page routes
  get 'external/about'
  get 'external/contact'
  get 'external/events'
  get 'external/home'
  get 'external/login'

  # internal page routes
  get 'internal/members'
  get 'internal/profile'

  # default route
  get ":controller(/:action(:id))"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
