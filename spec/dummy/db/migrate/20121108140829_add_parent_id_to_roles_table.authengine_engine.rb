# This migration comes from authengine_engine (originally 20110924165900)
class AddParentIdToRolesTable < ActiveRecord::Migration
  def change
    add_column :roles, :parent_id, :integer, :default => nil
  end
end
