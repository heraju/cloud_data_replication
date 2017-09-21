class CreateAdminUser < ActiveRecord::Migration
  def change
    User.create(email: 'admin@admin.com', password: 'password@123', admin: true)
  end
end
