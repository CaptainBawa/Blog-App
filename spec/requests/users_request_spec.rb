require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
    describe 'GET /users#index' do 
        it 'should check if respose status code is correct' do 
            get users_path
            expect(response).to have_http_status(200)
        end
        it 'should check if the response body includes correct placeholder text' do 
            get users_path
            expect(response.body).to include('Here is a list of all users')
        end
    end
    describe 'GET /user#show' do 
        user = User.create(name: 'John Doe', photo: 'photo_url', bio: 'bio_text', post_counter: 0)
        it 'should check if respose status code is correct' do 
            get user_path(id: user.id)
            expect(response).to have_http_status(200)
        end
        it 'should check if the response body includes correct placeholder text' do 
            get user_path(id: user.id)
            expect(response.body).to include('Here is a list of a specific user')
        end
    end
end