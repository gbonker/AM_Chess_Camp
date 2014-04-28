ChessCamp::Application.routes.draw do
  get "registrations/show"
  get "registrations/new"
  get "registrations/edit"
  get "students/show"
  get "students/new"
  get "students/index"
  get "students/edit"
  get "families/index"
  get "families/show"
  get "families/new"
  get "families/edit"
  get "locations/show"
  get "locations/edit"
  get "locations/index"
  get "locations/new"
  # generated routes
  resources :curriculums
  resources :instructors
  resources :camps
  resources :locations
  resources :families
  resources :students
  resources :registrations

  # semi-static routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy

  # set the root url
  root to: 'home#index'

end
