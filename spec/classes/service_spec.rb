require 'spec_helper'

describe 'gitea::service', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'with all defaults' do
        let :params do
          {
            manage_service: true,
            service_provider: 'systemd',
            installation_directory: '/opt/gitea',
          }
        end

        it { is_expected.to contain_service('gitea') }
      end
    end
  end
end
