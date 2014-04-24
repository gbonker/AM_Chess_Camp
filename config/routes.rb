ChessCamp::Application.routes.draw do
  get "families/index"
  get "families/show"
  get "families/new"
  get "families/edit"
  get "location/show"
  get "location/edit"
  get "location/index"
  get "location/new"
  # generated routes
  resources :curriculums
  resources :instructors
  resources :camps
  resources :location
  resources :families

  # semi-static routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy

  # set the root url
  root to: 'home#index'

end
