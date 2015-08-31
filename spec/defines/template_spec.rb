require 'spec_helper'

describe 'rsyslog::template', :type=>:define do
  let :pre_condition do
    'class {"rsyslog":}'
  end
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        describe 'rsyslog::template with required parameters' do
          let(:title) { 'tstfmt' }
          let(:params) { { 'format'=>'%fmtstr' } }
          it do
            is_expected.to contain_rsyslog__template('tstfmt')
            is_expected.to contain_file('rsyslog_template_tstfmt').with_content(/\$template tstfmt,%fmtstr/).with_path('/etc/rsyslog.d//0510_tstfmt.conf')
          end
        end
        describe 'rsyslog::template with priority given' do
          let(:title) { 'tstfmt' }
          let(:params) { { 'priority'=>'20','format'=>'%fmtstr' } }
          it do 
            is_expected.to contain_rsyslog__template('tstfmt')
            is_expected.to contain_file('rsyslog_template_tstfmt').with_content(/\$template tstfmt,%fmtstr/).with_path('/etc/rsyslog.d//0520_tstfmt.conf')
          end
        end
      end
    end
  end
end

