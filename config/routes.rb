Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "user_posts/users/:user_id", to: "posts#index"
  get "/user_post/:id", to: "posts#show"
  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
end
