#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{zsh sysv-rc-conf}.each do |pkg|
   package pkg do
     action :install
   end
end
