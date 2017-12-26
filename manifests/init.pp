# gitea
#
# Main class, includes all other classes.
#
# @summary Manage Gitea to run self-hosted Git services
#
# @example
#   include gitea
class gitea {
  contain ::gitea::packages
  contain ::gitea::user
  contain ::gitea::install
  contain ::gitea::config
  contain ::gitea::service

  Class['::gitea::packages']
  -> Class['::gitea::user']
  -> Class['::gitea::install']
  -> Class['::gitea::config']
  ~> Class['::gitea::service']
}
