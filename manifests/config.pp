# Class: gitea::config
# ===========================
#
# Applies configuration for `::gitea` class to system.
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
class gitea::config (
  $package_ensure         = $gitea::package_ensure,
  ) {
}
