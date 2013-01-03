class AddIdentifierToProducts < ActiveRecord::Migration
  def change
    add_column :products, :identifier, :string
  end
end
