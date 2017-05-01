require 'spec_helper'

describe 'gitea', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'with all defaults' do
        it { is_expected.to contain_class('gitea') }
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_anchor('gitea::begin') }
        it { is_expected.to contain_anchor('gitea::end') }
        it { is_expected.to contain_class('gitea::packages') }
        it { is_expected.to contain_class('gitea::user') }
        it { is_expected.to contain_class('gitea::install').that_comes_before('Class[gitea::config]') }
        it { is_expected.to contain_class('gitea::config').that_notifies('Class[gitea::service]') }
        it { is_expected.to contain_class('gitea::service') }
      end
    end
  end
end
