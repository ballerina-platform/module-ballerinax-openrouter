# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Nullable data binding issue — Fixed types in types.bal to correctly handle nullable fields, resolving data binding failures when the API returns optional/null values.
- Fixed include_disabled? query parameter type from string to boolean in the GET /keys endpoint

## [1.0.0]

### Added
- Initial release of the `ballerinax/openrouter` connector
- Client implementation for OpenRouter API v1
- Support for chat completions endpoint
- Test cases for the connector
- Examples:
  - AI model deployment pipeline
  - AI security audit
- Setup guide and documentation in README

[Unreleased]: https://github.com/ballerina-platform/module-ballerinax-openrouter/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/ballerina-platform/module-ballerinax-openrouter/releases/tag/v1.0.0
