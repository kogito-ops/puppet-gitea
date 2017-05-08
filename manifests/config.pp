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
# * `log_directory`
# Log directory for gitea. Default: '/var/log/gitea'
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
  $log_directory          = $gitea::log_directory,
  ) {

  $required_settings = {
    '' => {
      'RUN_USER' => $owner,
    },
    'repository' => {
      'ROOT' => $repository_root,
    },
    'log' => {
      'ROOT_PATH' => $log_directory,
    },
  }

  $gitea_configuration = {
    'path'    => "${installation_directory}/custom/conf/app.ini",
    'require' => File["${installation_directory}/custom/conf"],
  }

  $template_app_ini_sections = deep_merge($required_settings, $configuration_sections)

  file { "${installation_directory}/custom":
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
  }

  -> file { "${installation_directory}/custom/conf":
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
    notify => Exec["permissions:${installation_directory}/custom"],
  }

  create_ini_settings($template_app_ini_sections, $gitea_configuration)

  exec { "permissions:${installation_directory}/custom":
    command     => "chown -Rf ${owner}:${group} ${installation_directory}/custom",
    path        => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    refreshonly => true,
  }
}
