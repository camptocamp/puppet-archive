require 'spec_helper'

describe 'archive', :type => :define do
  let (:title) {'apache-tomcat-7.0.50'}
  let (:params) {
    {
        :ensure           => 'present',
        :url              => 'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.50/bin/apache-tomcat-7.0.50.tar.gz',
        :follow_redirects => true,
        :extension        => 'tar.gz',
        :checksum         => false,
        :src_target       => '/usr/local/src',
        :target           => '/tmp'
    }
  }
  it { should compile }

end