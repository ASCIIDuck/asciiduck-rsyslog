require 'spec_helper'

describe 'rsyslog::rule', :type=>:define do
  let :pre_condition do
    'class {"rsyslog":}'
  end
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        describe 'rsyslog::rule with file' do
          let(:title) { 'test' }
          let(:params) do 
            { 
              'pattern'=> '*.*',
              'file'=> '/dev/null',
            } 
          end
          it do
            is_expected.to contain_rsyslog__rule('test')
            is_expected.to contain_file('rsyslog_rule_test').with_content(/^\*\.\* \/dev\/null$/).with_path('/etc/rsyslog.d//1010_test.conf')
          end
        end
        describe 'rsyslog::rule with discard=true' do
          let(:title) { 'test' }
          let(:params) do 
            { 
              'pattern'=> '*.*',
              'discard'=> true,
            } 
          end
          it do 
            is_expected.to contain_rsyslog__rule('test')
            is_expected.to contain_file('rsyslog_rule_test').with_content(/^\*\.\* ~$/).with_path('/etc/rsyslog.d//1010_test.conf')
          end
        end
        describe 'rsyslog::rule with proto=udp, host=foo.example.com' do
          let(:title) { 'test' }
          let(:params) do
            { 
              'pattern'=> '*.*',
              'proto'=> 'udp',
              'host'=> 'foo.example.com',
            }
          end
          it do 
            is_expected.to contain_rsyslog__rule('test')
            is_expected.to contain_file('rsyslog_rule_test').with_content(/^\*\.\* @foo\.example\.com$/).with_path('/etc/rsyslog.d//1010_test.conf')
          end
        end
        describe 'rsyslog::rule with proto=tcp, host=foo.example.com' do
          let(:title) { 'test' }
          let(:params) do
            { 
              'pattern'=> '*.*',
              'proto'=> 'tcp',
              'host'=> 'foo.example.com',
            }
          end
          it do 
            is_expected.to contain_rsyslog__rule('test')
            is_expected.to contain_file('rsyslog_rule_test').with_content(/^\*\.\* @@foo\.example\.com$/).with_path('/etc/rsyslog.d//1010_test.conf')
          end
        end
        describe 'rsyslog::rule with proto=tcp, host=foo.example.com, port=10514' do
          let(:title) { 'test' }
          let(:params) do
            { 
              'pattern'=> '*.*',
              'proto'=> 'tcp',
              'host'=> 'foo.example.com',
              'port'=> '10514',
            }
          end
          it do 
            is_expected.to contain_rsyslog__rule('test')
            is_expected.to contain_file('rsyslog_rule_test').with_content(/^\*\.\* @@foo\.example\.com:10514$/).with_path('/etc/rsyslog.d//1010_test.conf')
          end
        end
        describe 'rsyslog::rule with proto=tcpo, host=foo.example.com' do
          let(:title) { 'test' }
          let(:params) do 
            { 
              'pattern'=> '*.*',
              'proto'=> 'tcpo',
              'host'=> 'foo.example.com',
            }
          end
          it do 
            is_expected.to contain_rsyslog__rule('test')
            is_expected.to contain_file('rsyslog_rule_test').with_content(/^\*\.\* @@\(o\)foo\.example\.com$/).with_path('/etc/rsyslog.d//1010_test.conf')
          end
        end
        describe 'rsyslog::rule with format given' do
          let(:title) { 'test' }
          let(:params) do
            { 
              'pattern'=> '*.*',
              'file'=> '/dev/null',
              'format' => '%some_template',
            }
          end
          it do 
            is_expected.to contain_rsyslog__rule('test')
            is_expected.to contain_file('rsyslog_rule_test').with_content(/^\*\.\* \/dev\/null;%some_template$/).with_path('/etc/rsyslog.d//1010_test.conf')
          end
        end
        describe 'rsyslog::rule with rules array given' do
          let(:title) { 'test' }
          let(:params) do
            { 
              'rules' => [ {
                  'pattern'=> '*.*',
                  'file'=> '/dev/null' },
                {
                  'pattern'=>'*.crit',
                  'file'=> '/var/log/gear.dog'
                } 
              ],
            }
          end
          it do 
            is_expected.to contain_rsyslog__rule('test')
            is_expected.to contain_file('rsyslog_rule_test').with_content(/^\*\.\* \/dev\/null$.*^\*\.crit \/var\/log\/gear\.dog$/m).with_path('/etc/rsyslog.d//1010_test.conf')
          end
        end
        describe 'rsyslog::rule with priority given' do
          let(:title) { 'test' }
          let(:params) do
            { 
              'pattern'=> '*.*',
              'file'=> '/dev/null',
              'priority' => 20,
            }
          end
          it do
            is_expected.to contain_rsyslog__rule('test')
            is_expected.to contain_file('rsyslog_rule_test').with_content(/^\*\.\* \/dev\/null$/).with_path('/etc/rsyslog.d//1020_test.conf')
          end
        end
        describe 'rsyslog::rule with manage_rsyslog = false' do
          let(:title) { 'test' }
          let(:params) do 
            { 
              'pattern'=> '*.*',
              'file'=> '/dev/null',
            } 
          end
          let :pre_condition do
            'class {"rsyslog": manage_rsyslog=>false }'
          end
          it do 
            is_expected.to contain_rsyslog__rule('test')
            is_expected.to have_file_count(0)
          end
        end
      end
    end
  end
end

