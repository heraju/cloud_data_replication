require 'rc4'
class UserUpload < ActiveRecord::Base
  has_many :fragments
  mount_uploader :file, DataUploader
  serialize :file, JSON
  belongs_to :user
  belongs_to :node
  @key = "drpa implementation ramaiah college"
  @fragment_size = 5

  def self.fragment_size
    Setting.last.fragment_size
  end

  def self.key
    @key
  end

  def rc_type_name
    case rc_type
    when 0
      'LMM'
    when 1
      'GMM'
    when 2
      'DRPA'
    when 3
      'Drops'
    when 4
      'Greedy'
    else
      'Unknown'
    end
  end


  def process_request
    case rc_type
    when 0
      lmm_request
    when 1
      gmm_request
    when 2
      drpa_request
    when 3
      drops_request
    when 4
      greedy_request
    else
      false
    end
  end

  def lmm_request
    servers = Node.get_servers((node.cost - 10), (node.cost + 10), UserUpload.fragment_size)
    upate_data_to_server(servers)
  end

  def gmm_request
    servers = Node.get_servers(0, 100, UserUpload.fragment_size)
    upate_data_to_server(servers)
  end

  def drpa_request
    servers = Node.get_servers(0, 100, UserUpload.fragment_size)
    upate_data_to_server(servers)
  end

  def drops_request
    servers = Node.get_t_coloring_servers(node.cost, UserUpload.fragment_size)
    upate_data_to_server(servers)
  end

  def greedy_request
    servers = Node.get_serial_servers(node.cost, UserUpload.fragment_size)
    upate_data_to_server(servers)
  end

  def upate_data_to_server(servers)
    fragments = create_fragments_of_file_data
    servers.each_with_index do |server, index|
      encrypted_fragment = encrypt_data(fragments[index])
      tmp_file = create_tmp_file(encrypted_fragment)
      Fragment.create(node_id: server.id, user_upload_id: id, order_id: index, fragment: tmp_file)
      File.delete('tmp/tmp_file.txt')
    end
  end

  def create_tmp_file(encrypted_fragment)
    file = File.open("tmp/tmp_file.txt", 'wb')
    file.puts(encrypted_fragment)
    file
  end

  def create_drpa_cache
    fragments.each do |fragment|
      tmp_file = create_tmp_file(fragment.fragment.file.read)
      new_server = Node.get_random_server(fragment.node_id)
      Fragment.create(node_id: new_server.id, user_upload_id: id, order_id: fragment.order_id, fragment: tmp_file)
      File.delete('tmp/tmp_file.txt')
    end
  end

  def encrypt_data(data)
    RC4.new(UserUpload.key).encrypt(data)
  end

  def decrypt_data(data)
    RC4.new(UserUpload.key).decrypt(data)
  end

  def create_fragments_of_file_data
    fragments = []
    file_data = file.file.read
    fragment_length = (file_data.length/UserUpload.fragment_size).to_i + 5
    file_data.scan(/.{1,#{fragment_length}}/)
  end

  def download
    data = []
    fragments.order('order_id ASC').each do |fragment|
      fragment.node.network_cost
      data << decrypt_data(fragment.fragment.file.read)
    end
    file_data = data.join(' ')
    file = File.open("tmp/downloads/#{Time.now.to_s}_#{self.file.file.filename}", 'wb')
    file.puts(file_data)
    file
  end

  def create_minima_cache(server)
    cost_hash = {}
    fragments.map{ |f| cost_hash[f.retrival_cost] = f.order_id }
    minima_value = cost_hash.keys.sort.uniq.first
    minima_value = cost_hash.keys.sort.uniq.first(2).first if minima_value == 0
    cost = server.cost + minima_value
    cost = server.cost - minima_value if cost > 100
    server = Node.find_by(cost: cost)
    order_id = cost_hash[minima_value]
    fragment = fragments.where(order_id: order_id).first
    tmp_file = create_tmp_file(fragment.fragment.file.read)
    Fragment.create(node_id: server.id, user_upload_id: id, order_id: order_id, fragment: tmp_file)
  end

  def post_download(server)
    if rc_type == 0 || rc_type == 1
      create_minima_cache(server)
    end
  end

end
