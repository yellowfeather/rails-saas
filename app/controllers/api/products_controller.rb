module Api
  class ProductsController < ApiController
    version 1

    caches :index, :show, :caches_for => 5.minutes

    def index
      expose Product.page(params[:page])
    end

    def show
      expose Product.find(params[:id])
    end

    def create
      expose Product.create(params[:product])
    end

    def update
      expose Product.update(params[:id], params[:product])
    end

    def destroy
      expose Product.destroy(params[:id])
    end
  end
end
