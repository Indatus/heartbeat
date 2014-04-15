if node['platform_family'] == 'rhel'
  execute "enable-CentOS-EPEL-repos" do 
    command "rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm"
    not_if "yum repolist | grep epel"
  end
end

case node['platform_family']
  when "debian"
    package_list = ['heartbeat']
  when "rhel"
    package_list = ['heartbeat']
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
unless node['heartbeat']['config']['shared_ip'].nil?

  #prevent ip conflicts w/ others sharing that IP
  execute "load-sysctl-settings" do
    command "/sbin/sysctl -p"
    action :nothing
  end

  template "/etc/sysctl.conf" do
    source "sysctl.conf.erb"
    mode "644"
    owner "root"
    group "root"
    notifies :run, "execute[load-sysctl-settings]", :immediately
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
  variables :shared_ip => node['heartbeat']['config']['shared_ip'], 
    :master_node => node['heartbeat']['config']['nodes'].first['hostname']
end