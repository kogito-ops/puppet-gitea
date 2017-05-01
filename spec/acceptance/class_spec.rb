require 'spec_helper_acceptance'

describe 'gitea class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class { 'gitea': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe group('git') do
      it { is_expected.to exist }
    end

    describe user('git') do
      it { is_expected.to exist }
    end

    describe file('/opt/gitea') do
      it { is_expected.to be_directory }
    end

    describe file('/opt/gitea/custom') do
      it { is_expected.to be_directory }
    end

    describe file('/opt/gitea/custom/conf') do
      it { is_expected.to be_directory }
    end

    describe file('/opt/gitea/custom/conf/app.ini') do
      it { is_expected.to be_file }
    end

    describe file('/opt/gitea/data') do
      it { is_expected.to be_directory }
    end

    describe file('/opt/gitea/log') do
      it { is_expected.to be_directory }
    end

    describe file('/opt/gitea/gitea') do
      it { is_expected.to be_file }
    end

    describe file('/var/git') do
      it { is_expected.to be_directory }
    end

    describe file('/lib/systemd/system/gitea.service') do
      it { is_expected.to be_file }
    end

    describe port(3000) do
      it { is_expected.to be_listening }
    end
  end
end
