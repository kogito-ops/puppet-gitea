# Changelog

All notable changes to this project will be documented in this file.

## Release 1.0.5 (NOT YET RELEASED)

**Features**

- Added `gitea::robots_txt` allowing to restrict creepy crawlers
- Added `gitea::lfs_content_directory` to allow customized LFS file paths

**Bugfixes**

- Removed coveralls integration.

## Release 1.0.4 (2017-11-13)

With this release, ownership of this module is transfered to Kogito UG,
a DevOps / Infrastructure services business in Berlin, Germany.

**Features**

- Base URL for Gitea downloads can now be pointed to a custom location
- Converted module to be Puppet Development Kit compatible
- Added support for Debian 9 (Stretch)
- Updated Puppet requirements to be in line with PE lifecycle

## Release 1.0.3 (2017-07-13)

**Features**

- Added `gitea::attachment_directory` to allow customized issue attachment paths
- Switched to using proper resource types in all places
- Updated module documentation

**Bugfixes**

- Added missing file logging mode

## Release 1.0.2 (2017-05-04)

**Features**

- Added `gitea::log_directory` to allow customized log paths

## Release 1.0.1 (2017-05-02)

**Bugfixes**

- Updated Travis CI build settings enabling automated module builds

## Release 1.0.0 (2017-05-02)

Initial release of Gitea management module. Hello, World!

**Known Issues**

- Travis CI build not (yet) working.
