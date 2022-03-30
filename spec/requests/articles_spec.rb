require 'rails_helper'

describe 'Articles', type: :request do
  describe 'GET /articles' do # index
    it 'responds with 200' do
      get articles_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /articles/new' do # new
    it 'responds with a 200' do
      get new_article_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /articles' do # create
    context 'with valid params' do
      it 'should increase Article.count by 1' do
        expect {
          post(articles_path, params: {
            article: {
              title: Faker::Book.title,
              body: Faker::Lorem.paragraph
            }
          })
        }.to change{ Article.count }.by(1)
      end

      it 'should respond with a 302' do
        post(articles_path, params: {
          article: {
            title: Faker::Kpop.i_groups,
            body: Faker::Lorem.paragraph
          }
        })

        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid params' do
      it 'should not increase Article.count' do
        expect{
          post(articles_path, params: {
            article: {
              title: nil,
              body: nil
            }
          })
        }.to change{ Article.count }.by(0)
      end

      it 'should respond with a 422' do
        post(articles_path, params: {
          article: {
            title: nil,
            body: nil
          }
        })
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET /articles/:id' do # show
    context 'with valid :id' do
      it 'responds with 200' do
        article = Article.create(
          title: Faker::Book.title,
          body: Faker::Lorem.paragraph
        )

        get article_path(article)
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid :id' do
      it 'raises RecordNotFound exception' do
        expect{
          get '/articles/invalid_id'
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET /articles/:id/edit' do # edit
    context 'with valid :id' do
      it 'responds with 200' do
        article = Article.create(
          title: Faker::Lorem.word,
          body: Faker::Lorem.paragraph
        )
        get edit_article_path(article)
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid :id' do
      it 'raises RecordNotFound exception' do
        expect{
          get '/articles/invalid_id/edit'
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'PUT /articles/:id' do # update
    context 'with valid params' do
      before(:each) do
        @article = Article.create(
          title: 'Initial',
          body: 'Initial body'
        )
      end

      it 'updates the article in the database' do
        expect(@article.title).to eq('Initial')

        put(article_path(@article), params: {
          article: {
            title: 'Test',
            body: 'Test body'
          }
        })

        expect(@article.reload.title).to eq('Test')
        expect(@article.reload.body).to eq('Test body')
      end

      it 'responds with a 302' do
        put(article_path(@article), params: {
          article: {
            title: 'Test',
            body: 'Test body'
          }
        })

        expect(response).to have_http_status(302)
      end
    end
    context 'with invalid params' do
      before(:each) do
        @article = Article.create(
          title: 'Initial',
          body: Faker::Lorem.paragraph
        )

        put(article_path(@article), params: {
          article: {
            title: nil,
            body: nil
          }
        })

      end
      it 'does not update the article' do
        expect(@article.reload.title).to eq('Initial')
      end
      it 'responds with 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /articles/:id' do # delete
    before(:each) do
      @article = Article.create(
        title: 'Initial',
        body: Faker::Lorem.paragraph
      )

      delete(article_path(@article))
    end

    it 'deletes the article from the database' do
      expect{
        Article.find(@article.id)
      }.to raise_exception(ActiveRecord::RecordNotFound)
    end

    it 'responds with a 302' do
      expect(response).to have_http_status(302)
    end
  end
end