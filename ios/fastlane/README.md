fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios prepare_certificates

```sh
[bundle exec] fastlane ios prepare_certificates
```

downloads and installs the appstore certificate for both CI
and local machines. Certificate is used to sign the version released to
itunes connect or firebase app distribution 

### ios deploy_firebase

```sh
[bundle exec] fastlane ios deploy_firebase
```

 prepares release notes based on JIRA tickets in commits since the last release,
uploads the build to firebase and adds a JIRA comment to every mentioned issue with build
 version, link to bitrise and link to firebase 

### ios deploy_testflight

```sh
[bundle exec] fastlane ios deploy_testflight
```

 deploys the build to testflight 

### ios deploy_pending_release

```sh
[bundle exec] fastlane ios deploy_pending_release
```

 promotes pending_release 

### ios add_ios_device

```sh
[bundle exec] fastlane ios add_ios_device
```

 adds new device's name and udid to the certificate and
 recreates the provisioning profiles 

### ios refresh_profiles

```sh
[bundle exec] fastlane ios refresh_profiles
```

 recreates the provisioning profiles for development, adhoc and appstore only if number
of registered devices have changed 

### ios download_udids

```sh
[bundle exec] fastlane ios download_udids
```



### ios check_testflight_version

```sh
[bundle exec] fastlane ios check_testflight_version
```

 checks current version in testflight 

### ios new_feature_branch

```sh
[bundle exec] fastlane ios new_feature_branch
```

 creates new feature branch from specified JIRA ticket number 

### ios verify_build_in_app_store

```sh
[bundle exec] fastlane ios verify_build_in_app_store
```

verifies ipa and metadata using fastlane deliver and checks for common errors

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
