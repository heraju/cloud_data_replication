class CreateFragments < ActiveRecord::Migration
  def change
    create_table :fragments do |t|
      t.integer :node_id
      t.integer :user_upload_id
      t.string :fragment
      t.integer :order_id

      t.timestamps
    end
  end
end
