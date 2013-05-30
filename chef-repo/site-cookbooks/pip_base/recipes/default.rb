#
# Cookbook Name:: pip_base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "python"

%w{ipython boto}.each do |pkg|
   python_pip pkg do
     action :install
   end
end

