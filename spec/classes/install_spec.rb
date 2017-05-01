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
            version: '1.1.0',
            checksum: '59cd3fb52292712bd374a215613d6588122d93ab19d812b8393786172b51d556',
            checksum_type: 'sha256',
            owner: 'git',
            group: 'git',
            installation_directory: '/opt/gitea',
            repository_root: '/var/git'
          }
        end

        it { is_expected.to contain_remote_file('/opt/gitea/gitea') }
        it { is_expected.to contain_file('/opt/gitea') }
        it { is_expected.to contain_file('/opt/gitea/data') }
        it { is_expected.to contain_file('/opt/gitea/log') }
        it { is_expected.to contain_file('/var/git') }
        it { is_expected.to contain_exec('permissions:/opt/gitea') }
        it { is_expected.to contain_exec('permissions:/opt/gitea/gitea') }
        it { is_expected.to contain_exec('permissions:/var/git') }
      end
    end
  end
end
