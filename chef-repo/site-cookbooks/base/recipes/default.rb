#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "python"

# packages
%w{zsh vim nano source-highlight build-essential git-core}.each do |pkg|
  package pkg do
    action :upgrade
  end
end

# python pip
%w{ipython boto PIL BeautifulSoup}.each do |pkg|
  python_pip pkg do
    action :upgrade
  end
end

# chef flags dir
directory "/var/chef_flags" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Assuming ubuntu user exists.
# config files of screen, and vim 
%w{screenrc vimrc}.each do |conf|
  cookbook_file "/home/#{node['base']['main_user']}/.#{conf}" do
    source "#{conf}"
    mode 0600
    owner node['base']['main_user']
    group node['base']['main_user']
  end
end

# rc.local
cookbook_file "/etc/rc.local" do
  mode 0755
  owner "root"
  group "root"
  source "rc.local"
end

directory "/etc/rc.local.d" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# config files for zsh
git "/home/#{node['base']['main_user']}/.zsh-completions" do
  repository "https://github.com/zsh-users/zsh-completions.git"
  reference "master"
  user node['base']['main_user']
  group node['base']['main_user']
  action :sync
end

template "zshrc" do
  source "zshrc.erb"
  path "/home/#{node['base']['main_user']}/.zshrc"
  mode 0600
  owner node['base']['main_user']
  group node['base']['main_user']
  variables(
    :machine_name => node['base']['machine_name']
  )
end

user node['base']['main_user'] do
  shell "/usr/bin/zsh"
  action :modify
end
