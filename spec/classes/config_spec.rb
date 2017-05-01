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
            repository_root: '/var/git'
          }
        end

        it { is_expected.to contain_file('/opt/gitea/custom') }
        it { is_expected.to contain_file('/opt/gitea/custom/conf') }
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
        end
      end
    end
  end
end