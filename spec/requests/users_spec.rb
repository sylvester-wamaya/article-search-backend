require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    it "Automatically creates a new user on submitting a search" do
      post users_path, params: { username: "127.0.0.1:3000", ip_address: "127.0.0.1:3000", password: "password" }, as: :json
      expect(response).to have_http_status(201)
    end

  end
end