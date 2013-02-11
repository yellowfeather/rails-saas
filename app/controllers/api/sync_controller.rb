module Api
  class SyncController < ApiController
    version 1
    doorkeeper_for :all

    #caches :index, :show, :caches_for => 5.minutes

    def index
      resource [ created, updated, deleted ]
    end

    def created
      paginated_collection :created, Product
        .where('created_at >= ?', params[:last_synced])
        .order('created_at ASC')
        .page(params[:page])
        .per(DEFAULT_PAGE_SIZE)
    end

    def updated
      paginated_collection :updated, Product
        .where('created_at < ?', params[:last_synced])
        .where('updated_at >= ?', params[:last_synced])
        .order('updated_at ASC')
        .page(params[:page])
        .per(DEFAULT_PAGE_SIZE)
    end

    def deleted
      # todo: get deleted products
      paginated_collection :deleted, Product
        .where('created_at is null')
        .page(params[:page])
        .per(DEFAULT_PAGE_SIZE)
    end
  end
end
