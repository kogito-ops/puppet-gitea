# Class: gitea::params
# ===========================
#
# Parameters and platform specific parameter preparation for `::gitea` class.
#
# Parameters
# ----------
#
# * `package_ensure`
# Should the package be 'absent', 'present' or its 'latest' version? Defaults to
# 'present'.
#
# * `package_install_options`
# Pass package specific options. Defaults to: empty.
#
# * `manage_package`
# Manage Gitea packages automatically. Defaults to `true`.
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
class gitea::params {
  $package_ensure          = 'present'
  $package_install_options = []
  $manage_package          = true

  case $::osfamily {
    default: {
      case $::operatingsystem {
        default: {
          fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
        }
      }
    }
  }
}
