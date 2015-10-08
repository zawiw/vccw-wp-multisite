#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


require 'shellwords'

# nginx install
service "httpd" do
  action [:stop, :disable]
end

# configure nginx
template "/etc/yum.repos.d/nginx.repo" do
  source "yum/nginx.repo.rb"
end

yum_repository 'nginx' do
  description 'Nginx.org Repository'
  url     node[:nginx][:repo]
  priority    '1'
  action :create
end

node[:nginx][:packages].each do | pkg |
  package pkg do
    action [:install, :upgrade]
    options "--enablerepo=epel"
  end
end

# configure nginx
template "/etc/nginx/nginx.conf" do
  variables node[:nginx][:config]
  source "nginx/nginx.conf.erb"
  notifies :reload, 'service[nginx]'
end

%w{ drop expires mobile-detect phpmyadmin php-fpm wp-multisite-subdir wp-singlesite }.each do | file_name |
  template "/etc/nginx/" + file_name do
    variables node[:nginx][:config]
    source "nginx/" + file_name + ".erb"
    notifies :reload, 'service[nginx]'
  end
end

%w{ default.conf default.backend.conf }.each do | file_name |
  template "/etc/nginx/conf.d/" + file_name do
    variables(
      :server_name => node[:nginx][:wp_host],
      :phpmyadmin_enable => node[:nginx][:config][:phpmyadmin_enable]
    )
    source "nginx/conf.d/" + file_name + ".erb"
    notifies :reload, 'service[nginx]'
  end
end

%W{ /var/cache/nginx /var/log/nginx /var/lib/nginx /var/tmp/nginx /var/www/vhosts/#{node[:nginx][:wp_host]} }.each do | dir_name |
  directory dir_name do
    owner node[:nginx][:config][:user]
    group node[:nginx][:config][:group]
    mode 00755
    recursive true
    action :create
  end
end


service "nginx" do
  action node[:nginx][:service_action]
end