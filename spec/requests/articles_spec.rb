require 'rails_helper'

RSpec.describe "articles", type: :request do
  describe "POST /articles" do
    it "creates a new article" do
      post articles_path, params: { title: 'Article 10', description: "Vogue Daily. The latest in top fashion stories, editor's picks, and celebrity style. ... The latest fashion news, beauty coverage, celebrity style, fashion week ... ", url: 'https://www.google.com/', image: 'https://marketplace.canva.com/EAFj2v65I38/2/'}, as: :json
      expect(response).to have_http_status(:created)
    end

    it "It fetches the articles" do
      post articles_path, params: { title: 'Article 10', description: "Vogue Daily. The latest in top fashion stories, editor's picks, and celebrity style. ... The latest fashion news, beauty coverage, celebrity style, fashion week ... ", url: 'https://www.google.com/', image: 'https://marketplace.canva.com/EAFj2v65I38/2/'}, as: :json


      get articles_path
      expect(response.body).to include('Article 10')
    end
  end
end
