# special thanks to John Keiser

# this is the part that the script would generate
class Chef::Resource::SuperCluster < Chef::Resource::LWRPBase
  default_action :create
  allowed_actions :create, :destroy
  attribute :cluster_name
  attribute :max_servers
end

class Chef::Provider::SuperCluster < Chef::Provider::LWRPBase
  why_run true
  use_inline_resources true

  action :create do
    aws_security_group 'name_of_choice' do
      ...
    end
    load_balancer 'my_lb' do
      max_size new_resource.max_servers
    end
  end

  action :destroy do
    load_balancer 'my_lb' do
      action :destroy
    end
    aws_security_group 'name_of_choice' do
      action :destroy
    end
  end
end


#  and you use it by putting this in a recipe
super_cluster 'my_cluster' do
  max_servers 10
end

