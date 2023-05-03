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

### android jira_tickets_set_fixversion

```sh
[bundle exec] fastlane android jira_tickets_set_fixversion
```

 gets all tickets since last tag and updates fix version for involved Jira tickets 

### android jira_get_release_notes

```sh
[bundle exec] fastlane android jira_get_release_notes
```

 gets all tickets since last tag and generates changelog out of involved Jira tickets 

### android jira_check_ticket_mergeable

```sh
[bundle exec] fastlane android jira_check_ticket_mergeable
```

 checks whether ticket is mergeable 

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
