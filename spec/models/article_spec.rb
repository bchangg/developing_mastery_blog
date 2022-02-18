require 'rails_helper'

RSpec.describe Article, type: :model do
  context 'is valid' do
    it 'with a title and a body' do
      article = Article.new
      article.title = Faker::Name.name
      article.body = Faker::Lorem.paragraph

      expect(article).to be_valid
    end
  end

  context 'is not valid' do
    it 'without a title and body' do
      article = Article.new

      expect(article).to_not be_valid
    end

    it 'without a title' do
      article = Article.new
      article.body = Faker::Lorem.paragraph

      expect(article).to_not be_valid
    end

    it 'without a body' do
      article = Article.new
      article.title = Faker::Name.name

      expect(article).to_not be_valid
    end
  end
end
