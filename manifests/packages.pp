# Class: gitea::packages
# ===========================
#
# Manages dependencies for the `::gitea` class.
#
# Parameters
# ----------
#
# * `dependencies_ensure`
# Should dependencies be installed? Defaults to 'present'.
#
# * `dependencies`
# List of OS family specific dependencies.
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
class gitea::packages (
  Enum['latest','present','absent'] $dependencies_ensure = $gitea::dependencies_ensure,
  Array[String] $dependencies = $gitea::dependencies,
  ) {

  if ($dependencies_ensure) {
    ensure_packages($dependencies, {'ensure' => $dependencies_ensure})
  }
}
