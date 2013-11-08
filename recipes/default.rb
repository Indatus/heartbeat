case node['platform_family']
  when "debian"
    package_list = ['heartbeat', 'heartbeat-dev']
end

package_list.each do |pkg|
  package pkg do
    action :install
  end
end

service "heartbeat" do
  supports(
    :restart => true,
    :status => true
  )
  action :enable
end

#add the shared IP
unless node['heartbeat']['config']['shared_ip']['address'].nil?

  # #add shared IP to the interface list
  # execute "add shared ip" do 

  #   addy = node['heartbeat']['config']['shared_ip']

  #   cmd = "auto #{addy['interface']}\n"
  #   cmd += "iface #{addy['interface']} inet static\n"
  #   cmd += "\taddress #{addy['address']}\n"
  #   cmd += "\tnetmask #{addy['netmask']}\n"

  #   command "printf \"#{cmd}\" >> /etc/network/interfaces"
  #   not_if "cat /etc/network/interfaces | grep #{addy['address']}"
  # end

  #prevent ip conflicts w/ others sharing that IP
  execute "prevent shared ip conflict" do 
    command "echo \"net.ipv4.ip_nonlocal_bind=1\" >> /etc/sysctl.conf && sysctl -p"
    not_if "cat /etc/sysctl.conf | grep net.ipv4.ip_nonlocal_bind"
  end
end


template "#{node['heartbeat']['conf_dir']}/ha.cf" do
  source "ha.cf.erb"
  mode "644"
  owner "root"
  group "root"
  notifies :restart, "service[heartbeat]"
  mirror_node = node['heartbeat']['config']['nodes'].detect {|x| x['hostname'] != node['hostname']}
  variables :mirror_node_ip => mirror_node ? mirror_node['ip'] : ''
end


template "#{node['heartbeat']['conf_dir']}/authkeys" do
  source "authkeys.erb"
  owner "root"
  group "root"
  mode "600"
  notifies :restart, "service[heartbeat]"
end


template "#{node['heartbeat']['conf_dir']}/haresources" do
  source "haresources.erb"
  owner "root"
  group "root"
  mode "644"
  notifies :restart, "service[heartbeat]"
  variables :shared_ip => node['heartbeat']['config']['shared_ip']['address'], 
    :master_node => node['heartbeat']['config']['nodes'].first['hostname']
end