# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.15.1](https://github.com/microsoft/kiota-abstractions-ruby/compare/v0.15.0...v0.15.1) (2026-04-23)


### Bug Fixes

* update minimum required ruby version to 3.3.0 ([26e398e](https://github.com/microsoft/kiota-abstractions-ruby/commit/26e398eb42b82b5ca86fa51088f55e1dd5edfdab))
* update minimum required ruby version to 3.3.0 ([da96f19](https://github.com/microsoft/kiota-abstractions-ruby/commit/da96f1934b4ae16dac85a8e3ac0a9133da6ef1a0))

## [0.15.0](https://github.com/microsoft/kiota-abstractions-ruby/compare/v0.14.4...v0.15.0) (2026-04-20)


### Features

* add workflow_dispatch trigger to all workflows ([e7ec34e](https://github.com/microsoft/kiota-abstractions-ruby/commit/e7ec34e12163689550c84dafe336ead7f37fe3b1))
* upgrade ruby CI matrix to 3.3, 3.4 and 4.0 ([b8ae278](https://github.com/microsoft/kiota-abstractions-ruby/commit/b8ae2789b67ec2f4a8d92af233dea81bdf46b803))
* upgrade ruby CI matrix to 3.3, 3.4 and 4.0 ([2ab5a2e](https://github.com/microsoft/kiota-abstractions-ruby/commit/2ab5a2e454ac0da738a6e70daf85834a94e281ec))


### Bug Fixes

* anonymous authentication provider did not return a fiber resulting in a failure ([29b9d31](https://github.com/microsoft/kiota-abstractions-ruby/commit/29b9d31003d787e453c39ec9c039bf575f599463))

## [Unreleased]

### Added

### Changed

## [0.14.4] - 2024-01-06

### Changed

- Fixed a bug that was causing the content not to be set in the request information.

## [0.14.3] - 2023-10-11

### Added

- Added a content type parameter to the stream content method of request information.

## [0.14.2] - 2023-10-06

### Added

- Added a try_add method for request headers

## [0.14.1] - 2023-09-06

### Changed

- Switched to std URI template

## [0.14.0] - 2023-03-14

### Added

- Added a base request builder and request configuration class to reduce the amount of generated code.

### Changed

- Bumped minimum required ruby version to 3.0.

## [0.13.0] - 2023-01-10

### Added

- Added a method to convert abstract requests to native requests in the request adapter interface.

## [0.12.0] - 2022-12-30

### Added

- Initial public release of the package.
