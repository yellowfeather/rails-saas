class Tombstone < ActiveRecord::Base
  attr_accessible :klass, :sync_id
end
