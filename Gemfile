source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :development, :test do
  gem 'rake'
  gem 'puppetlabs_spec_helper', :require => false
  gem 'rspec-puppet',           :require => false
  gem 'rspec-system-puppet',    :require => false
  gem 'puppet-lint',            :require => false
  gem 'serverspec',             :require => false
  gem 'travis',                 :require => false
  gem 'travis-lint',            :require => false
  gem 'pry',                    :require => false
  gem 'puppet-syntax',          :require => false, :git => 'git://github.com/curator/puppet-syntax.git', :branch => 'puppet_3_fix'
  gem 'librarian-puppet',       :require => false
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

# vim:ft=ruby
