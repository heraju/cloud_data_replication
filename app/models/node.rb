class Node < ActiveRecord::Base
  has_many :fragments

  def self.get_servers(cost_min, cost_max, total_servers)
    servers = []
    (1..total_servers).each do |server|
      server = nil
      while !server
        random = rand(cost_min..cost_max)
        server = Node.find_by(cost: random)
      end
      servers << server
    end
    servers
  end

  def self.get_serial_servers(cost, total_servers)
    servers = []
    new_cost = cost + (total_servers*2)
    cost = cost - (total_servers*2) if new_cost > 100
    (1..total_servers).each do |server|
      server = Node.find_by(cost: cost)
      cost = cost + 2
      servers << server
    end
    servers
  end

  def network_cost(current_server)
    rep_cost = Node.nw_cost_bw_servers(self, current_server)
    (0..rep_cost).each do |i|
      p "waiting #{i}"
      # network costing loop
    end
  end

  def self.get_random_server(exclude)
    random = rand(0..100)
    Node.find_by(cost: random)
  end

  def self.get_t_coloring_servers(cost, total_servers)
    servers = []
    new_cost = cost + (total_servers*8)
    cost = cost - (total_servers*8) if new_cost > 100
    (1..total_servers).each_with_index do |server, index|
      server = Node.find_by(cost: cost)
      cost = cost + ((index+1)*3+1)
      servers << server
    end
    servers
  end

  def self.nw_cost_bw_servers(server_1, server_2)
    p "#{server_1.name} --- #{server_2.name}"
    if server_1.cost > server_2.cost
      return server_1.cost - server_2.cost
    else
      return server_2.cost - server_1.cost
    end
  end

end
