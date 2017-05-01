# puppet-gitea

[![Build Status][build-shield]][build-status]
[![Puppet Forge][forge-shield]][forge-gitea]
[![Puppet Forge - downloads][forge-shield-dl]][forge-gitea]
[![Puppet Forge - scores][forge-shield-sc]][forge-gitea]

## Description

A Puppet module for managing [Gitea][gitea] (Git with a cup of tea) settings.
This module allows you to install and configure Gitea using pre-built binaries
and does not need external package repositories. You can chose to install Gitea
with default settings, or customize all settings to your liking.

## Setup

### What Gitea affects

*   `puppet-gitea` depends on
    *   [puppetlabs-stdlib][puppetlabs-stdlib],
    *   [puppetlabs-inifile][puppetlabs-inifile],
    *   [lwf-remote_file][lwf-remote_file],
*   it install dependencies for gitea: `curl`, `git` and `tar`
*   it manages a user and group `git`
*   it manages the gitea directory (`/opt/gitea`) and the repositories (`/var/git`)
*   it install a `gitea` service listening on port `3000`

### Beginning with Gitea

The simplest use case is to rely on defaults. This can be done by simply
including the class:

```puppet
include ::gitea
```

## Usage

TODO

## Reference

### Class: `gitea`

```puppet
class { 'gitea':
}
```

### Class: `gitea::install`

```puppet
class { 'gitea::install':
}
```

### Class: `gitea::service`

```puppet
class { 'gitea::service':

```

### Class: `gitea::config`

```puppet
class { 'gitea::config':

```

## Limitations

See [metadata.json](metadata.json) for supported platforms

## Development

### Running tests

This project contains tests for [rspec-puppet][puppet-rspec].

Quickstart:

```bash
$ gem install bundler
$ bundle install
$ bundle exec rake test
```

When submitting pull requests, please make sure that module documentation,
test cases and syntax checks pass.

[gitea]: https://github.com/go-gitea/gitea
[puppetlabs-stdlib]: https://github.com/puppetlabs/puppetlabs-stdlib
[puppetlabs-inifile]: https://github.com/puppetlabs/puppetlabs-inifile
[lwf-remote_file]: https://github.com/lwf/puppet-remote_file
[puppet-rspec]: http://rspec-puppet.com/

[build-status]: https://travis-ci.org/kogitoapp/puppet-gitea
[build-shield]: https://travis-ci.org/kogitoapp/puppet-gitea.png?branch=master
[forge-gitea]: https://forge.puppetlabs.com/kogitoapp/gitea
[forge-shield]: https://img.shields.io/puppetforge/v/kogitoapp/gitea.svg
[forge-shield-dl]: https://img.shields.io/puppetforge/dt/kogitoapp/gitea.svg
[forge-shield-sc]: https://img.shields.io/puppetforge/f/kogitoapp/gitea.svg
