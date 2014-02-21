require 'rubygems'
require 'bundler/setup'

require 'rspec-system/rake_task'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'

require 'rake/clean'

CLEAN.include('spec/fixtures/manifests/', 'spec/fixtures/modules/', 'doc', 'pkg')
CLOBBER.include('.tmp', '.librarian')

PuppetLint.configuration.send("disable_80chars")
PuppetLint.configuration.send('disable_class_parameter_defaults')
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.log_format = "%{path}:%{linenumber}:%{check}:%{KIND}:%{message}"
PuppetLint.configuration.fail_on_warnings = true

ENV['MODULEPATH'] = 'spec/fixtures/modules/'

exclude_paths = [
  "pkg/**/*",
  "vendor/**/*",
  "spec/**/*",
]
PuppetLint.configuration.ignore_paths = exclude_paths
PuppetSyntax.exclude_paths = exclude_paths

task :librarian_spec_prep do
 sh "librarian-puppet install --path=spec/fixtures/modules/"
end

# # override spec prep to use librarian-puppet over fixtures
task :spec_prep => :librarian_spec_prep

# desc "with syntax, and lint tests"
task :spec => [:clean, :syntax, :lint]
