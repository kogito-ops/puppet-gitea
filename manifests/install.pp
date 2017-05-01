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

  -> file { "${installation_directory}/log":
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
  }

  if ($package_ensure) {
    $kernel_down=downcase($::kernel)

    remote_file { "${$installation_directory}/gitea":
      ensure        => $package_ensure,
      source        => "https://github.com/go-gitea/gitea/releases/download/v${version}/gitea-${version}-${kernel_down}-${::architecture}",
      checksum      => $checksum,
      checksum_type => $checksum_type,
      notify        => [
        Exec["permissions:${$installation_directory}/gitea"]
      ],
    }
  }

  exec { "permissions:${installation_directory}":
    command     => "/bin/chown -Rf ${owner}:${group} ${installation_directory}",
    refreshonly => true,
  }

  exec { "permissions:${$installation_directory}/gitea":
    command     => "/bin/chmod +x ${$installation_directory}/gitea",
    refreshonly => true,
  }

  exec { "permissions:${repository_root}":
    command     => "/bin/chown -Rf ${owner}:${group} ${repository_root}",
    refreshonly => true,
  }
}
