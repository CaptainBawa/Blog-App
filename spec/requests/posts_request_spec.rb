require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
      user = User.create(name: 'John Doe', photo: 'photo_url', bio: 'bio_text', post_counter: 0)
      post = Post.create(title: 'Test', text: 'Post content', author_id: user.id, comments_counter: 0, likes_counter: 0)

    describe 'GET /posts#index' do 
        it 'should check if respose status code is correct' do 
            get user_posts_path(author_id: user.id)
            expect(response).to have_http_status(200)
        end
        it 'should check if the response body includes correct placeholder text' do 
            get user_posts_path(author_id: user.id)
            expect(response.body).to include('Here is a list of posts for a given user')
        end
        it 'should render the index template' do
            get user_posts_path(author_id: user.id)
            expect(response).to render_template(:index)
        end
    end
end