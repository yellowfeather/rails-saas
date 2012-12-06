class HomeController < ApplicationController
  def index
    redirect_to products_path if valid_subdomain
  end
end
