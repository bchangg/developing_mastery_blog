class HomeController < ApplicationController
  def landing
    redirect_to articles_path
  end
end