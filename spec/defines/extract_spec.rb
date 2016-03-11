require 'spec_helper'
 
describe 'archive::extract' do

  default_facts = {
    :path => '/usr/bin:/bin',
    :osfamily => 'Debian'
  }

  let(:title) { 'apache-tomcat-6.0.26' }
  let(:params) {{
    :target => '/opt'
  }}

  context 'with minimal parameters' do
    let(:facts) { default_facts }
    it { should contain_exec('apache-tomcat-6.0.26 unpack').with_command(/&& tar /) }
  end

  context 'in Solaris' do
    let (:facts) { default_facts.merge({
      :osfamily => 'Solaris'
    }) }
    it { should contain_exec('apache-tomcat-6.0.26 unpack').with_command(/&& gtar /) }
  end
  
end