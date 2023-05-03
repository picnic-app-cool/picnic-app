fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android deploy_firebase

```sh
[bundle exec] fastlane android deploy_firebase
```

 prepares release notes based on JIRA tickets in commits since the last release,
uploads the build to firebase and adds a JIRA comment to every mentioned issue with build
 version, link to bitrise and link to firebase 

### android deploy_google_alpha

```sh
[bundle exec] fastlane android deploy_google_alpha
```

 prepares release for google play 

### android deploy_google_play

```sh
[bundle exec] fastlane android deploy_google_play
```

 promotes latest alpha build to production 

### android check_google_play_version

```sh
[bundle exec] fastlane android check_google_play_version
```

 checks current version in google play alpha 

### android verify_build_in_google_play

```sh
[bundle exec] fastlane android verify_build_in_google_play
```

verifies aab and metadata using fastlane deliver and checks for common errors

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
