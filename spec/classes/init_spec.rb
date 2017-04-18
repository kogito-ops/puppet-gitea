require 'spec_helper'

describe 'gitea', type: :class do
  context 'on non supported operating systems' do
    let(:facts) { { osfamily: 'foo', operatingsystem: 'bar' } }

    it 'fails' do
      is_expected.to compile.and_raise_error(%r{Unsupported platform: foo/bar})
    end
  end

  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end
      options = os_specific_options(facts)
      context 'with all defaults' do
        it { is_expected.to contain_class('gitea') }
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_anchor('gitea::begin') }
        it { is_expected.to contain_anchor('gitea::end') }
        it { is_expected.to contain_class('gitea::install').that_comes_before('Class[gitea::config]') }
        it { is_expected.to contain_class('gitea::config') }
      end
    end
  end
end
