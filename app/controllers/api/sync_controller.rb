module Api
  class SyncController < ApiController
    version 1
    doorkeeper_for :all

    #caches :index, :show, :caches_for => 5.minutes

    def index
      h = {
            :last_synced => Time.now.utc,
            :created => created,
            :updated => updated,
            :deleted => deleted
          }
      resource h
    end

    def created
      products = Product
        .order('created_at ASC')
        .page(params[:page])
        .per(DEFAULT_PAGE_SIZE)

      if params.has_key?(:last_synced)
        products = products.where('created_at >= ?', params[:last_synced])
      end

      paginated_collection products
    end

    def updated
      products = Product
        .order('updated_at ASC')
        .page(params[:page])
        .per(DEFAULT_PAGE_SIZE)

      if params.has_key?(:last_synced)
        products = products
          .where('created_at < ?', params[:last_synced])
          .where('updated_at >= ?', params[:last_synced])
      end

      paginated_collection products
    end

    def deleted
      tombstones = Tombstone
        .order('created_at ASC')
        .page(params[:page])
        .per(DEFAULT_PAGE_SIZE)

      if params.has_key?(:last_synced)
        tombstones = tombstones.where('created_at >= ?', params[:last_synced])
      end

      paginated_collection tombstones
    end
  end
end

