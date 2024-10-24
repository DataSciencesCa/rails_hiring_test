Rails.application.routes.draw do
  resources :ridings do
    member do
      get :edit_polling_locations
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "ridings#index"
end
