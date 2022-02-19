class Article < ApplicationRecord
  validates :title, presence: true
  # TODO: if there's a draft feature, can consider removing this body presence as the user would have a way to not publish articles
  validates :body, presence: true
end