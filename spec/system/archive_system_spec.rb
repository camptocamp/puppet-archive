require 'spec_helper_system'

describe 'base tests:' do
  it 'should have the module to test' do
    # just bail if the module we're testing isn't there
    shell("ls /etc/puppet/modules/archive") do |r|
      r.exit_code.should eq(0)
      r.stdout.should match /Modulefile/
      r.stderr.should eq('')
    end
  end

  it 'should make sure a puppet agent has run' do
    puppet_agent do |r|
      r.stderr.should eq('')
      r.exit_code.should eq(0)
    end
  end

  # Using puppet_apply as a helper
  it 'my class should work with no errors' do
    pp = <<-EOS
      archive { 'apache-tomcat-7.0.50':
        ensure           => present,
        url              => 'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.50/bin/apache-tomcat-7.0.50.tar.gz',
        follow_redirects => true,
        extension        => 'tar.gz',
        checksum         => false,
        src_target       => '/usr/local/src',
        target           => '/tmp'
      }
    EOS

    # Run it twice and test for idempotency
    puppet_apply(pp) do |r|
      r.exit_code.should_not == 1
      r.refresh
      r.exit_code.should be_zero
    end
  end
end
