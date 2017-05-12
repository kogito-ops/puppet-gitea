# Class: gitea::install
# ===========================
#
# Installs gitea, and sets up the directory structure required to run Gitea.
#
# Parameters
# ----------
#
# * `package_ensure`
# Decides if the `gitea` binary will be installed. Default: 'present'
#
# * `owner`
# The user owning gitea and its' files. Default: 'git'
#
# * `group`
# The group owning gitea and its' files. Default: 'git'
#
# * `version`
# Version of gitea to install. Default: '1.1.0'
#
# * `checksum`
# Checksum for the binary.
# Default: '59cd3fb52292712bd374a215613d6588122d93ab19d812b8393786172b51d556'
#
# * `checksum_type`
# Type of checksum used to verify the binary being installed. Default: 'sha256'
#
# * `installation_directory`
# Target directory to hold the gitea installation. Default: '/opt/gitea'
#
# * `repository_root`
# Directory where gitea will keep all git repositories. Default: '/var/git'
#
# * `log_directory`
# Log directory for gitea. Default: '/var/log/gitea'
#
# * `attachment_directory`
# Directory for storing attachments. Default: '/opt/gitea/data/attachments'
#
# * `manage_service`
# Should we manage a service definition for Gitea?
#
# * `service_template`
# Path to service template file.
#
# * `service_path`
# Where to create the service definition.
#
# * `service_provider`
# Which service provider do we use?
#
# * `service_mode`
# File mode for the created service definition.
#
# Authors
# -------
#
# Daniel S. Reichenbach <daniel@kogitoapp.com>
#
# Copyright
# ---------
#
# Copyright 2016-2017 Daniel S. Reichenbach <https://kogitoapp.com>
#
class gitea::install (
  $package_ensure         = $gitea::package_ensure,
  $owner                  = $gitea::owner,
  $group                  = $gitea::group,

  $version                = $gitea::version,
  $checksum               = $gitea::checksum,
  $checksum_type          = $gitea::checksum_type,
  $installation_directory = $gitea::installation_directory,
  $repository_root        = $gitea::repository_root,
  $log_directory          = $gitea::log_directory,
  $attachment_directory   = $gitea::attachment_directory,

  $manage_service         = $gitea::manage_service,
  $service_template       = $gitea::service_template,
  $service_path           = $gitea::service_path,
  $service_provider       = $gitea::service_provider,
  $service_mode           = $gitea::service_mode,
  ) {

  file { $repository_root:
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
    notify => Exec["permissions:${repository_root}"],
  }

  -> file { $installation_directory:
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
    notify => Exec["permissions:${installation_directory}"],
  }

  -> file { "${installation_directory}/data":
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
  }

  -> file { $attachment_directory:
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
    notify => Exec["permissions:${attachment_directory}"],
  }

  -> file { $log_directory:
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
    notify => Exec["permissions:${log_directory}"],
  }

  if ($package_ensure) {
    $kernel_down=downcase($::kernel)

    case $::architecture {
      /(x86_64)/: {
        $arch = 'amd64'
      }
      /(x86)/: {
        $arch = '386'
      }
      default: {
        $arch = $::architecture
      }
    }

    $source_url="https://github.com/go-gitea/gitea/releases/download/v${version}/gitea-${version}-${kernel_down}-${arch}"

    remote_file { 'gitea':
      ensure        => $package_ensure,
      path          => "${installation_directory}/gitea",
      source        => $source_url,
      checksum      => $checksum,
      checksum_type => $checksum_type,
      notify        => [
        Exec["permissions:${$installation_directory}/gitea"],
        Service['gitea']
      ],
    }
  }

  exec { "permissions:${installation_directory}":
    command     => "chown -Rf ${owner}:${group} ${installation_directory}",
    path        => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    refreshonly => true,
  }

  exec { "permissions:${$installation_directory}/gitea":
    command     => "chmod +x ${$installation_directory}/gitea",
    path        => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    refreshonly => true,
  }

  exec { "permissions:${repository_root}":
    command     => "chown -Rf ${owner}:${group} ${repository_root}",
    path        => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    refreshonly => true,
  }

  exec { "permissions:${log_directory}":
    command     => "chown -Rf ${owner}:${group} ${log_directory}",
    path        => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    refreshonly => true,
  }

  exec { "permissions:${attachment_directory}":
    command     => "chown -Rf ${owner}:${group} ${attachment_directory}",
    path        => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    refreshonly => true,
  }

  if ($manage_service) {
    file { "service:${service_path}":
      path    => $service_path,
      content => template($service_template),
      mode    => $service_mode,
    }
  }
}
