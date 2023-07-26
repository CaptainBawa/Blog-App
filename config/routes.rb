Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # a route that maps the URL "/users/:author_id/posts"
  # to the "index" action of the "posts" controller.
   # It a Nested route to access posts for a specific user
  get "/users/:author_id/posts", to: "posts#index", as: :user_posts
 # a route that maps the URL "/posts/:id" to the "show"
 # action of the "posts" controller.
  get "/posts/:id", to: "posts#show", as: :user_post
  # a route that maps the URL "/users" to the "index" action
  # of the "users" controller. This means that when a user
  # visits the "/users" URL, the "index" action in the
  #"users" controller will be executed.
  root "users#index"
  # a route that maps the URL "/users/:id" to the "show"
  # action of the "users" controller.
  get "/users/:id", to: "users#show", as: :user
end
