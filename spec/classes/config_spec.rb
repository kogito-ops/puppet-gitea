require 'spec_helper'

describe 'gitea::config', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'with all defaults' do
        let :params do
          {
            configuration_sections: {},
            owner: 'git',
            group: 'git',
            installation_directory: '/opt/gitea',
            repository_root: '/var/git',
            log_directory: '/var/log/gitea'
          }
        end

        it { is_expected.to contain_file('/opt/gitea/custom') }
        it { is_expected.to contain_file('/opt/gitea/custom/conf') }
        it { is_expected.to contain_exec('permissions:/opt/gitea/custom') }
        it do
          is_expected.to contain_ini_setting('/opt/gitea/custom/conf/app.ini [] RUN_USER').with(
            section: '',
            setting: 'RUN_USER',
            value: 'git',
            path: '/opt/gitea/custom/conf/app.ini'
          )
          is_expected.to contain_ini_setting('/opt/gitea/custom/conf/app.ini [repository] ROOT').with(
            section: 'repository',
            setting: 'ROOT',
            value: '/var/git',
            path: '/opt/gitea/custom/conf/app.ini'
          )
          is_expected.to contain_ini_setting('/opt/gitea/custom/conf/app.ini [log] ROOT_PATH').with(
            section: 'log',
            setting: 'ROOT_PATH',
            value: '/var/log/gitea',
            path: '/opt/gitea/custom/conf/app.ini'
          )
          is_expected.to contain_ini_setting('/opt/gitea/custom/conf/app.ini [log] MODE').with(
            section: 'log',
            setting: 'MODE',
            value: 'file',
            path: '/opt/gitea/custom/conf/app.ini'
          )
        end
      end
    end
  end
end
