require 'spec_helper'

describe 'rsyslog' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "rsyslog class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('rsyslog') }
          it { is_expected.to contain_class('rsyslog::params') }
          it { is_expected.to contain_class('rsyslog::install').that_comes_before('rsyslog::base_config') }
          it { is_expected.to contain_class('rsyslog::base_config') }
          it { is_expected.to contain_class('rsyslog::service').that_subscribes_to('rsyslog::base_config') }

          it { is_expected.to contain_service('rsyslog') }
          if facts[:osfamily].eql?('RedHat') and facts[:operatingsystemmajrelease].eql?('5') then
            it { is_expected.to contain_package('rsyslog5').with_ensure('present') }
          else
            it { is_expected.to contain_package('rsyslog').with_ensure('present') }
          end
          if facts[:osfamily].eql?('RedHat') and facts[:operatingsystemmajrelease].eql?('7') then
            it { is_expected.to contain_file('/etc/rsyslog.conf').with_content(/\$ModLoad imjournal/) }
          else
            it { is_expected.to contain_file('/etc/rsyslog.conf').with_content(/\$ModLoad imklog/) }
          end
          it { is_expected.to contain_file('/etc/rsyslog.d/').with_ensure('directory') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'rsyslog class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('rsyslog') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
