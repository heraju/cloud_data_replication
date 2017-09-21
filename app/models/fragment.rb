class Fragment < ActiveRecord::Base
  mount_uploader :fragment, DataUploader
  belongs_to :node
  belongs_to :user_upload

  def retrival_cost
    upload_server_cost = user_upload.node.cost
    fragment_node_cost = node.cost
    if upload_server_cost > fragment_node_cost
      return upload_server_cost - fragment_node_cost
    else
      return fragment_node_cost - upload_server_cost
    end
  end

end
