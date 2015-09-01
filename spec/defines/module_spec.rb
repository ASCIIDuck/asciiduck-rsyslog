require 'spec_helper'

describe 'rsyslog::module', :type=>:define do
  let :pre_condition do
    'class {"rsyslog":}'
  end
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        describe 'rsyslog::module without any parameters' do
          let(:title) { 'imtest' }
          it do 
            is_expected.to contain_rsyslog__module('imtest')
            is_expected.to contain_file('rsyslog_module_imtest').with_content(/^\$ModLoad imtest$/).with_path('/etc/rsyslog.d//0010_imtest.conf')
          end
        end
        describe 'rsyslog::module with additional parameters' do
          let(:title) { 'imtest' }
          let(:params) { { 'parameters'=>{'$IMTestFoo'=>'bar' } } }
          it do
            is_expected.to contain_rsyslog__module('imtest')
            is_expected.to contain_file('rsyslog_module_imtest').with_content(/^\$ModLoad imtest$.*^\$IMTestFoo bar$/m).with_path('/etc/rsyslog.d//0010_imtest.conf')
          end
        end
        describe 'rsyslog::module with priority given' do
          let(:title) { 'omtest' }
          let(:params) { { 'priority'=>'20' } }
          it do 
            is_expected.to contain_rsyslog__module('omtest')
            is_expected.to contain_file('rsyslog_module_omtest').with_content(/^\$ModLoad omtest$/).with_path('/etc/rsyslog.d//0020_omtest.conf')
          end
        end
        describe 'rsyslog::module with manage_rsyslog = false' do
          let(:title) { 'omtest' }
          let :pre_condition do
            'class {"rsyslog": manage_rsyslog=>false }'
          end
          it do 
            is_expected.to contain_rsyslog__module('omtest')
            is_expected.to have_file_count(0)
          end
        end
      end
    end
  end
end

