module Api
  class SyncController < ApiController
    version 1
    doorkeeper_for :all

    #caches :index, :show, :caches_for => 5.minutes

    def index
      h = { :created => created, :updated => updated, :deleted => deleted }
      resource h
    end

    def created
      paginated_collection Product
        .where('created_at >= ?', params[:last_synced])
        .order('created_at ASC')
        .page(params[:page])
        .per(DEFAULT_PAGE_SIZE)
    end

    def updated
      paginated_collection Product
        .where('created_at < ?', params[:last_synced])
        .where('updated_at >= ?', params[:last_synced])
        .order('updated_at ASC')
        .page(params[:page])
        .per(DEFAULT_PAGE_SIZE)
    end

    def deleted
      paginated_collection Tombstone
        .where('created_at >= ?', params[:last_synced])
        .order('created_at ASC')
        .page(params[:page])
        .per(DEFAULT_PAGE_SIZE)
    end
  end
end
