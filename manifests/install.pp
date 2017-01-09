# Class: gitea::install
# ===========================
#
# Installs and configures and system package(s) required for setting up Gitea.
#
# Parameters
# ----------
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
class gitea::install (
  $package_ensure          = $gitea::package_ensure,
  $package_install_options = $gitea::package_install_options,
  $manage_package          = $gitea::manage_package,
  ) {
}
