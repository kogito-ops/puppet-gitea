require 'spec_helper'

describe 'gitea::user', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'with all defaults' do
        let :params do
          {
            manage_user: true,
            manage_group: true,
            manage_home: true,
            owner: 'git',
            group: 'git',
            home: '/home/git',
          }
        end

        it { is_expected.to contain_group('git') }
        it { is_expected.to contain_user('git') }
      end
    end
  end
end
