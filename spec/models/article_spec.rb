require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'is valid with a title and body' do
    article = Article.new
    article.title = Faker::Name.name
    article.body = Faker::Lorem.paragraph

    expect(article).to be_valid
  end

  it 'is valid with a title' do
    article = Article.new
    article.title = Faker::Name.name

    expect(article).to be_valid
  end


  it 'is not valid without a title' do
    article = Article.new

    expect(article).to_not be_valid
  end

  it 'is valid with a unique title' do
    article_1 = Article.new
    article_2 = Article.new

    article_1.title = 'test 1'
    article_2.title = 'test 2'
    article_1.save
    article_2.save

    expect(article_1).to be_valid
    expect(article_2).to be_valid
    expect(Article.count).to eq(2)
  end

  it 'is not valid if title is not unique' do
    article_1 = Article.new
    article_2 = Article.new

    article_1.title = 'test 1'
    article_2.title = 'test 1'
    article_1.save
    article_2.save

    expect(article_1).to be_valid
    expect(article_2).to_not be_valid
    expect(Article.count).to eq(1)
  end
end
