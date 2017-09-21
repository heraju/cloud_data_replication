class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.integer :cost
      t.string :location

      t.timestamps
    end
  end
end
