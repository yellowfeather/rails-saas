class HomeController < ApplicationController
  def index
    redirect_to products_path if current_tenant
  end
end
