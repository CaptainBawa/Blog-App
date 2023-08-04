Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  devise_for :users

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

  # a route that maps the URL "/posts" to the "create" action of the "posts"
  # controller. This means that when a user submits a POST request to the "/posts"
  # URL, the "create" action in the "posts" controller will be executed.
  post "/posts", to: "posts#create"

 # a route that maps the URL "/posts/:id/comments" to the "create_comment"
 # action of the "posts" controller.
  post "/posts/:id/comments", to: "comments#create_comment", as: :post_comments

 # a route that maps the URL "/posts/:id/likes" to the "create_like"
 # action of the "posts" controller.
  post "/posts/:id/likes", to: "likes#create_like", as: :post_likes

  # route that maps the URL "/users/:author_id/posts" to the "create" action of the "posts"
  # controller.
  post "/users/:author_id/posts", to: "posts#create", as: :create_user_post

  # Adding the routes for deleting posts and comments
delete "/posts/:id", to: "posts#destroy", as: :delete_post
delete "/comments/:id", to: "comments#destroy", as: :delete_comment
end
