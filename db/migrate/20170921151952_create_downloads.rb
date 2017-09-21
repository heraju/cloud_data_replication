class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.integer :user_id
      t.integer :user_upload_id
      t.string :description
      t.boolean :apporve

      t.timestamps
    end
  end
end
