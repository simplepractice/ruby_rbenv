#
# Cookbook:: ruby_rbenv
# Resource:: gem
#
# Author:: Fletcher Nichol <fnichol@nichol.ca>
#
# Copyright:: 2011-2017, Fletcher Nichol
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

provides :rbenv_gem
# Standard Gem Package Options
# https://docs.chef.io/resource_gem_package.html#attributes
property :clear_sources, [true, false]
property :include_default_source, [true, false]
property :options, [String, Hash]
property :package_name, [String, Array], name_property: true
property :source, [String, Array]
property :timeout, Integer, default: 300
property :version, String
property :response_file, String # Only used to reconfig
property :user, String
property :rbenv_version, String

default_action :install

action :install do
  gem_package new_resource.package_name do
    clear_sources new_resource.clear_sources if new_resource.clear_sources
    include_default_source new_resource.include_default_source if new_resource.include_default_source
    gem_binary binary
    options new_resource.options if new_resource.options
    package_name new_resource.package_name if new_resource.package_name
    source new_resource.source if new_resource.source
    timeout new_resource.timeout if new_resource.timeout
    version new_resource.version if new_resource.version
    action :install
  end
end

action :purge do
  gem_package new_resource.package_name do
    clear_sources new_resource.clear_sources if new_resource.clear_sources
    include_default_source new_resource.include_default_source if new_resource.include_default_source
    gem_binary binary
    options new_resource.options if new_resource.options
    package_name new_resource.package_name if new_resource.package_name
    source new_resource.source if new_resource.source
    timeout new_resource.timeout if new_resource.timeout
    version new_resource.version if new_resource.version
    action :purge
  end
end

action :reconfig do
  gem_package new_resource.package_name do
    clear_sources new_resource.clear_sources if new_resource.clear_sources
    include_default_source new_resource.include_default_source if new_resource.include_default_source
    gem_binary binary
    options new_resource.options if new_resource.options
    package_name new_resource.package_name if new_resource.package_name
    source new_resource.source if new_resource.source
    timeout new_resource.timeout if new_resource.timeout
    version new_resource.version if new_resource.version
    response if new_resource.response_file
    action :reconfig
  end
end

action :remove do
  gem_package new_resource.package_name do
    clear_sources new_resource.clear_sources if new_resource.clear_sources
    include_default_source new_resource.include_default_source if new_resource.include_default_source
    gem_binary binary
    options new_resource.options if new_resource.options
    package_name new_resource.package_name if new_resource.package_name
    source new_resource.source if new_resource.source
    timeout new_resource.timeout if new_resource.timeout
    version new_resource.version if new_resource.version
    action :remove
  end
end

action :upgrade do
  gem_package new_resource.package_name do
    clear_sources new_resource.clear_sources if new_resource.clear_sources
    include_default_source new_resource.include_default_source if new_resource.include_default_source
    gem_binary binary
    options new_resource.options if new_resource.options
    package_name new_resource.package_name if new_resource.package_name
    source new_resource.source if new_resource.source
    timeout new_resource.timeout if new_resource.timeout
    version new_resource.version if new_resource.version
    action :upgrade
  end
end

action_class do
  include Chef::Rbenv::ScriptHelpers

  def binary
    prefix = if new_resource.user
      "sudo -u #{new_resource.user}"
    end

    "#{prefix} #{root_path}/versions/#{new_resource.rbenv_version}/bin/gem"
  end
end
