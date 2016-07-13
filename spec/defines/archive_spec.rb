require 'spec_helper'

describe 'archive' do
  let(:title) { 'apache-tomcat-6.0.26' }

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'without parameters' do
        it { expect { is_expected.to compile.with_all_deps }.to raise_error(/url/) }
      end

      context 'with url, without target' do
        let(:params) do
          {
            :url => 'http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26.tar.gz',
          }
        end

        it { expect { is_expected.to compile.with_all_deps }.to raise_error(/target/) }
      end

      context 'with target, without url' do
        let(:params) do
          {
            :target => '/opt',
          }
        end
        
        it { expect { is_expected.to compile.with_all_deps }.to raise_error(/url/) }
      end

      context 'with url and target' do
        let(:params) do
          {
            :url => 'http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26.tar.gz',
            :target => '/opt',
          }
        end

        it { is_expected.to compile.with_all_deps }
      end

      context 'with url and purge target' do
        let(:params) do
          {
            :url => 'http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26.tar.gz',
            :target => '/opt/tc6',
            :purge_target => true,
          }
        end

        it { is_expected.to compile.with_all_deps }
      end

      context 'with url, target and user' do
        let(:params) do
          {
            :url    => 'http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26.tar.gz',
            :target => '/opt',
            :user   => 'root',
          }
        end

        it { is_expected.to compile.with_all_deps }
      end

      context 'with custom tar command' do
        let(:params) do
          {
            :url         => 'http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.26/bin/apache-tomcat-6.0.26.tar.gz',
            :target      => '/opt',
            :tar_command => 'xtar',
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { should contain_archive__extract('apache-tomcat-6.0.26').with_tar_command('xtar') }
      end
    end
  end
end
