#
# Cookbook Name:: rabbitmq
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# change hostname
bash "change_hostname" do
  user "root"
  not_if "hostname | grep -q rabbit01"
  code <<-EOH
  echo "rabbit01" > /etc/hostname
  echo "127.0.0.1 rabbit01" >> /etc/hosts
  hostname -F /etc/hostname
  EOH
end

# install package
package 'rabbitmq-server' do
  version "2.7.1"
  action :upgrade
end

# rabbitmq user and vhost setting
bash "rabbitmq_setting" do
  flag_file = "/var/chef_flags/rabbitmq_setting"
  user "root"
  not_if { ::File.exists?(flag_file) }
  code <<-EOH
  rabbitmqctl add_user rabbit rabbit
  rabbitmqctl delete_user guest
  rabbitmqctl add_vhost /vmhost
  rabbitmqctl set_permissions -p /vmhost rabbit ".*" ".*" ".*"
  touch #{flag_file} 
  EOH
end

# disable rabbitmq-server auto start
service "rabbitmq-server" do
  action :disable
end

# rc.local
cookbook_file "/etc/rc.local.d/#{node['rc']['rabbitmq_order']}_rabbitmq" do
  source "rc.rabbitmq"
  owner 'root'
  group 'root'
end
