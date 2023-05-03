fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Mac

### mac prepare_certificates

```sh
[bundle exec] fastlane mac prepare_certificates
```



### mac add_macos_device

```sh
[bundle exec] fastlane mac add_macos_device
```

 adds new device's name and udid to the certificate and
 recreates the provisioning profiles 

### mac refresh_profiles

```sh
[bundle exec] fastlane mac refresh_profiles
```

 recreates the provisioning profiles for development, adhoc and appstore only if number
of registered devices have changed 

### mac notarize_macos

```sh
[bundle exec] fastlane mac notarize_macos
```

notarizes macOS build to make it available for everyone to install without any gatekeeper errors

### mac notarize_macos_dmg

```sh
[bundle exec] fastlane mac notarize_macos_dmg
```

notarizes macOS DMG image to make it available for everyone to install without any gatekeeper errors

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
