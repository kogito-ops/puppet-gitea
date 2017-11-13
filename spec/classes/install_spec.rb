require 'spec_helper'

describe 'gitea::install', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'with all defaults' do
        let :params do
          {
            package_ensure: 'present',
            base_url: 'https://github.com/go-gitea/gitea/releases/download',
            version: '1.1.0',
            checksum: '59cd3fb52292712bd374a215613d6588122d93ab19d812b8393786172b51d556',
            checksum_type: 'sha256',
            owner: 'git',
            group: 'git',
            installation_directory: '/opt/gitea',
            repository_root: '/var/git',
            log_directory: '/var/log/gitea',
            attachment_directory: '/opt/gitea/data/attachments',
            manage_service: true,
            service_template: 'gitea/systemd.erb',
            service_path: '/lib/systemd/system/gitea.service',
            service_provider: 'systemd',
            service_mode: '0644',
          }
        end

        it { is_expected.to contain_remote_file('gitea') }
        it { is_expected.to contain_file('/opt/gitea') }
        it { is_expected.to contain_file('/opt/gitea/data') }
        it { is_expected.to contain_file('/opt/gitea/data/attachments') }
        it { is_expected.to contain_file('/var/log/gitea') }
        it { is_expected.to contain_file('/var/git') }
        it { is_expected.to contain_file('service:/lib/systemd/system/gitea.service') }
        it { is_expected.to contain_exec('permissions:/opt/gitea') }
        it { is_expected.to contain_exec('permissions:/opt/gitea/gitea') }
        it { is_expected.to contain_exec('permissions:/opt/gitea/data/attachments') }
        it { is_expected.to contain_exec('permissions:/var/log/gitea') }
        it { is_expected.to contain_exec('permissions:/var/git') }
      end
    end
  end
end
