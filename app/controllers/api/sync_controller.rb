module Api
  class SyncController < ApiController
    version 1
    doorkeeper_for :all

    #caches :index, :show, :caches_for => 5.minutes

    def index
      create
      update
      delete

      h = {
            :last_synced => Time.now.utc,
            :created => created,
            :updated => updated,
            :deleted => deleted
          }
      resource h
    end

    def create
      if !params.has_key?(:created)
        return;
      end

      entities = params[:created]
      products = entities[:products]
      products.each do |product|
        Product.create(product)
      end
    end

    def update
      if !params.has_key?(:updated)
        return;
      end

      entities = params[:updated]
      products = entities[:products]
      products.each do |product|
        p = Product.find_by_sync_id(product[:sync_id])
        p.update_attributes(product) unless p.nil?
      end
    end

    def delete
      if !params.has_key?(:deleted)
        return;
      end

      entities = params[:deleted]
      entities.each do |entity|
        p = Product.find_by_sync_id(entity[:sync_id])
        p.destroy unless p.nil?
      end
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

