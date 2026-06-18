## [Unreleased]

## [0.0.2] - 2026-06-17
 - Allow Ruby 4.0.0:
    - Relaxed `required_ruby_version` to `>= 2.5.0, < 5.0`
    - Added Ruby 4.0.0 to the CI matrix
    - Bumped `faraday-follow_redirects` upper bound to allow 0.5+ (which lifts the Ruby < 4 cap)
    - Dropped the `bundler` development dependency
    - Added `rexml` and `irb` development dependencies (no longer in stdlib on Ruby 4)
 - Fixed copy-paste residue: 503 error message said "Crossref is rate limiting your requests." (Crossref is the upstream serrano template's API) — changed to "OpenAlex is rate limiting your requests."

## [0.0.1] - 2025-07-11

- Initial release
