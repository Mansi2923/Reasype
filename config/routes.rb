Rails.application.routes.draw do
  root "home#index"

  # Static pages
  get "/about", to: "home#about"
  get "/contact", to: "home#contact"
  get "/recipes", to: "home#recipes"

  # API routes
  post "/ingredient_photos", to: "ingredient_photos#create"
  get "/ingredient_photos/:id", to: "ingredient_photos#show"
  post "/ingredient_photos/test", to: "ingredient_photos#test"

  post "/recipes/generate", to: "recipes#generate"
  get "/recipes/:id", to: "recipes#show"
  post "/recipes/save", to: "recipes#save"

  resources :cooking_sessions, only: [ :create, :show ]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
