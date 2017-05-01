# Class: gitea
# ===========================
#
# Manages a Gitea installation on various Linux/BSD operating systems.
#
# Parameters
# ----------
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
