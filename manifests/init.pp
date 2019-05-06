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
# * `proxy`
# Download via specified proxy. Default: empty
#
# * `base_url`
# Download base URL. Default: Github. Can be used for local mirrors.
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
# * `attachment_directory`
# Directory for storing attachments. Default: '/opt/gitea/data/attachments'
#
# * `lfs_enabled`
# Make use of git-lfs. Default: false
#
# * `lfs_content_directory`
# Directory for storing LFS data. Default: '/opt/gitea/data/lfs'
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
# Copyright 2016-2019 Daniel S. Reichenbach <https://kogitoapp.com>
#
class gitea (
  Enum['present','absent'] $package_ensure,
  Enum['latest','present','absent'] $dependencies_ensure,
  Array[String] $dependencies,

  Boolean $manage_user,
  Boolean $manage_group,
  Boolean $manage_home,
  String $owner,
  String $group,
  Optional[String] $home,

  Optional[String] $proxy,
  String $base_url,
  String $version,
  String $checksum,
  String $checksum_type,
  String $installation_directory,
  String $repository_root,
  String $log_directory,
  String $attachment_directory,
  Boolean $lfs_enabled,
  String $lfs_content_directory,

  Hash $configuration_sections,

  Boolean $manage_service,
  String $service_template,
  String $service_path,
  String $service_provider,
  String $service_mode,
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
