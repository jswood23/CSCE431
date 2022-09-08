Rails.application.routes.draw do
  # root route at external/home
  root "external#home"

  # default route
  get ":controller(/:action(:id))"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
