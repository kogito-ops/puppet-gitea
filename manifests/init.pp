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
# Copyright 2016 Daniel S. Reichenbach <https://kogitoapp.com>
#
class gitea (
  $package_ensure,
  $package_install_options,
  $manage_package,
  ) {

  class { '::gitea::install':
    package_install_options => $package_install_options,
  }

  class { '::gitea::config': }

  anchor { 'gitea::begin': }
  anchor { 'gitea::end': }

  Anchor['gitea::begin']
  -> Class['gitea::install']
  -> Class['gitea::config']
}
