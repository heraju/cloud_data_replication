class AddServerToUpload < ActiveRecord::Migration
  def change
    add_column :user_uploads, :node_id, :integer
  end
end
