require 'rspec-system/spec_helper'
require 'rspec-system-puppet/helpers'

include RSpecSystemPuppet::Helpers

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # fixtures
  fixtures = 'spec/fixtures/modules'

  # Enable colour
  c.tty = true

  c.include RSpecSystemPuppet::Helpers

  c.before :suite do

    # install puppet stuff
    puppet_install
    puppet_master_install

    # install base module
    puppet_module_install(:source => proj_root, :module_name => 'archive')

    # install dependencies from fixtures using librarian-puppet
    Dir.chdir(proj_root) do
      %x[librarian-puppet install --path=spec/fixtures/modules]
      Dir.foreach(fixtures) do |dep|
        next if dep == '.' || dep == '..'
        puppet_module_install(:source => fixtures + '/' + dep, :module_name => dep)
      end
    end
  end

end