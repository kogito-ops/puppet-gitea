# Class: gitea::service
# ===========================
#
# Manages services for the `::gitea` class.
#
# Parameters
# ----------
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
class gitea::service (
  $manage_service   = $gitea::manage_service,
  $service_template = $gitea::service_template,
  $service_path     = $gitea::service_path,
  $service_provider = $gitea::service_provider,
  $service_mode     = $gitea::service_mode,
  ) {
}
