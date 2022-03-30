require 'rails_helper'

describe 'Home', type: :request do
  describe 'GET /' do
    it 'responds with 302' do
      get root_path
      expect(response).to have_http_status(302)
    end
    it 'redirects to /articles' do
      get root_path
      expect(response).to redirect_to(articles_path)
    end
  end
end