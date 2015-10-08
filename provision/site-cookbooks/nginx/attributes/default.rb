## Nginx
default[:nginx][:packages] = %w{ nginx }
default[:nginx][:repo] =  "http://nginx.org/packages/mainline/centos/$releasever/$basearch/"
default[:nginx][:wp_host] = "vccw.dev"
default[:nginx][:service_action] = [:enable, :start]
default[:nginx][:config][:user] = 'nginx'
default[:nginx][:config][:group] = 'nginx'
default[:nginx][:config][:worker_processes] = '2'
default[:nginx][:config][:client_max_body_size] = '4M'
default[:nginx][:config][:proxy_read_timeout] = '90'
default[:nginx][:config][:worker_rlimit_nofile] = '10240'
default[:nginx][:config][:worker_connections] = '8192'
##default[:nginx][:config][:phpmyadmin_enable] = true
default[:nginx][:config][:UA_ktai] = '(DoCoMo|J-PHONE|Vodafone|MOT-|UP\.Browser|DDIPOCKET|ASTEL|PDXGW|Palmscape|Xiino|sharp pda browser|Windows CE|L-mode|WILLCOM|SoftBank|Semulator|Vemulator|J-EMULATOR|emobile|mixi-mobile-converter|PSP)'
default[:nginx][:config][:UA_smartphone] ='(iPhone|iPod|incognito|webmate|Android|dream|CUPCAKE|froyo|BlackBerry|webOS|s8000|bada|IEMobile|Googlebot\-Mobile|AdsBot\-Google)'
default[:nginx][:config][:UA_smartphone_off] ='wptouch[^\\=]+\\=(normal|desktop)'
