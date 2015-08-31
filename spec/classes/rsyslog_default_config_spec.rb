require 'spec_helper'

describe 'rsyslog::default_config' do
  let :pre_condition do
    'class {"rsyslog":}'
  end
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        context "rsyslog class without any parameters" do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('rsyslog') }
          it { is_expected.to contain_class('rsyslog::default_config') }
          it { is_expected.to contain_rsyslog__rule('defaults') }
          it { is_expected.to contain_file('rsyslog_rule_defaults').with_path('/etc/rsyslog.d//1050_defaults.conf') }
        end
      end
    end
  end
end
