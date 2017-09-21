class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :node_count
      t.integer :fragment_size

      t.timestamps
    end
    Setting.create(node_count: 5, fragment_size: 5)
  end
end
