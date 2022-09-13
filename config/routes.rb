Rails.application.routes.draw do
  # root route at external/home
  root "external#home"

  # external page routes
  get "/home", to: "external#home"
  get "/about", to: "external#about"
  get "/events", to: "external#events"
  get "/contact", to: "external#contact"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
