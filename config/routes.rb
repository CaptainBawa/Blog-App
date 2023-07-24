Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # Nested route to access posts for a specific user
  get "/users/:author_id/posts", to: "posts#index", as: :user_posts
  # Route to access a specific post
  get "/posts/:id", to: "posts#show", as: :user_post
  get "/users", to: "users#index"
  get "/users/:id", to: "users#show", as: :user
end
