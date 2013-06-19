#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"

# Repository info : http://www.waltercedric.com/all-my-hobbies/352-linux/2073-ubuntu-1204-update-nginx-to-the-latest-version
apt_repository "nginx" do
  uri "http://nginx.org/packages/ubuntu/"
  distribution "precise"
  components ["nginx"]
  key "http://nginx.org/packages/keys/nginx_signing.key"
end

package "nginx" do
  version "1.4.1"
  action :upgrade
end

%w{php5-cli php5-cgi php5-gd spawn-fcgi}.each do |pkg|
  package pkg do
    action :install
  end
end