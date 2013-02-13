require 'uuid'

module Extensions
  module Syncable
    extend ActiveSupport::Concern

    included do |klass|
      klass.before_create do
        self.sync_id = UUID.generate
      end

      klass.before_destroy do
        Tombstone.create(:klass => self.class.name.demodulize.downcase, :sync_id => self.sync_id)
      end
    end
  end
end
