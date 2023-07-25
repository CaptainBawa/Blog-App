require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
    describe 'GET /users' do 
        it 'should check if respose status code is correct' do 
            get users_path
            expect(response).to have_http_status(200)
        end
    end
end