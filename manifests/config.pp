# Class: gitea::config
# ===========================
#
# Applies configuration for `::gitea` class to system.
#
# Parameters
# ----------
#
# * `configuration_sections`
# INI style settings for configuring Gitea.
#
# * `owner`
# The user owning gitea and its' files. Default: 'git'
#
# * `group`
# The group owning gitea and its' files. Default: 'git'
#
# * `installation_directory`
# Target directory to hold the gitea installation. Default: '/opt/gitea'
#
# * `repository_root`
# Directory where gitea will keep all git repositories. Default: '/var/git'
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
class gitea::config (
  $configuration_sections = $gitea::configuration_sections,
  $owner                  = $gitea::owner,
  $group                  = $gitea::group,
  $installation_directory = $gitea::installation_directory,
  $repository_root        = $gitea::repository_root,
  ) {

  $default_sections = {
    '' => {
      'RUN_USER' => $owner,
    },
    'repository' => {
      'ROOT' => $repository_root,
    },
  }

  $gitea_configuration = {
    'path'    => "${installation_directory}/custom/conf/app.ini",
    'require' => File["${installation_directory}/custom/conf"],
  }

  $template_app_ini_sections = deep_merge($default_sections, $configuration_sections)

  file { "${installation_directory}/custom":
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
  }

  -> file { "${installation_directory}/custom/conf":
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
  }

  create_ini_settings($template_app_ini_sections, $gitea_configuration)
}
