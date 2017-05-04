# Class: gitea
# ===========================
#
# Manages a Gitea installation on various Linux/BSD operating systems.
#
# Parameters
# ----------
#
# * `package_ensure`
# Decides if the `gitea` binary will be installed. Default: 'present'
#
# * `dependencies_ensure`
# Should dependencies be installed? Defaults to 'present'.
#
# * `dependencies`
# List of OS family specific dependencies.
#
# * `manage_user`
# Should we manage provisioning the user? Default: true
#
# * `manage_group`
# Should we manage provisioning the group? Default: true
#
# * `manage_home`
# Should we manage provisioning the home directory? Default: true
#
# * `owner`
# The user owning gitea and its' files. Default: 'git'
#
# * `group`
# The group owning gitea and its' files. Default: 'git'
#
# * `home`
# Qualified path to the users' home directory. Default: empty
#
# * `version`
# Version of gitea to install. Default: '1.1.0'
#
# * `checksum`
# Checksum for the binary.
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
# * `configuration_sections`
# INI style settings for configuring Gitea.
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
# Examples
# --------
#
# @example
#    class { 'gitea':
#    }
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
class gitea (
  $package_ensure,
  $dependencies_ensure,
  $dependencies,

  $manage_user,
  $manage_group,
  $manage_home,
  $owner,
  $group,
  $home,

  $version,
  $checksum,
  $checksum_type,
  $installation_directory,
  $repository_root,
  $log_directory,

  $configuration_sections,

  $manage_service,
  $service_template,
  $service_path,
  $service_provider,
  $service_mode,
  ) {

  class { '::gitea::packages': }
  class { '::gitea::user': }
  class { '::gitea::install': }

  class { '::gitea::config': }
  class { '::gitea::service': }

  anchor { 'gitea::begin': }
  anchor { 'gitea::end': }

  Anchor['gitea::begin']
  -> Class['gitea::packages']
  -> Class['gitea::user']
  -> Class['gitea::install']
  -> Class['gitea::config']
  ~> Class['gitea::service']
}
