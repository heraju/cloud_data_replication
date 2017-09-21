class CreateUserUploads < ActiveRecord::Migration
  def change
    create_table :user_uploads do |t|
      t.integer :user_id
      t.string :file
      t.string :key
      t.integer :rc_type

      t.timestamps
    end
  end
end
