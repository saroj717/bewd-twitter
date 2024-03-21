require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  describe 'POST /users' do
    it 'renders new user object' do
      post :create, params: {
        user: {
          email: 'test@test.com',
          password: 'asdasdasd',
          username: 'test'
        }
      }

      expect(response).to have_http_status(:created) # Ensure user is created successfully
      response_hash = JSON.parse(response.body)
      puts "Response body: #{response.body}"
      expect(response_hash['user']).to include("username" => "test", "email" => "test@test.com")
    end
  end
end
