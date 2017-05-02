# Class: gitea::user
# ===========================
#
# Manages user for the `::gitea` class.
#
# Parameters
# ----------
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
class gitea::user (
  $manage_user  = $gitea::manage_user,
  $manage_group = $gitea::manage_group,
  $manage_home  = $gitea::manage_home,
  $owner        = $gitea::owner,
  $group        = $gitea::group,
  $home         = $gitea::home,
  ) {

  if ($manage_home) {
    if $home == undef {
      $homedir = "/home/${owner}"
    } else {
      $homedir = $home
    }
  }

  if ($manage_user) {
    group { $group:
      ensure => present,
      system => true,
    }
  }

  if ($manage_user) {
    user { $owner:
      ensure     => present,
      gid        => $group,
      home       => $homedir,
      managehome => $manage_home,
      system     => true,
      require    => Group[$group],
    }
  }
}
