class CreateServers < ActiveRecord::Migration
  def change
    (0..100).each do |i|
      location = "Bangalore" if i > 0
      location = "Hyderabad" if i > 20
      location = "Delhi" if i > 30
      location = "Singapore" if i > 40
      location = "United kingdom" if i > 50
      location = "United States - SFO" if i > 60
      location = "United States - NC" if i > 70
      location = "United States - WC" if i > 80
      location = "United States - Albama" if i > 90
      Node.create(name: "Data server - #{i}", location: location, cost: i)
    end

  end
end
