class HomeController < ApplicationController
  def index
    redirect_to products_path if valid_subdomain
  end

  def tour

  end

  def pricing

  end

  def why

  end

  def testimonials

  end

  def about

  end
end
