require 'rails_helper'

RSpec.describe "Searches", type: :request do
  describe "POST /searches" do
    it "creates a new search" do
      post searches_path, params: { search: 'Fashion' }, as: :json
      expect(response).to have_http_status(:ok)
    end

    it "It saves the final search" do
      post searches_path, params: { searchValue: 'Fashion' }, as: :json
      post searches_path, params: { searchValue: 'Fashion for' }, as: :json
      post searches_path, params: { searchValue: 'Fashion for Tech' }, as: :json

      get searches_search_stats_path
      expect(response.body).to include('Fashion for Tech')
    end
  end
end
