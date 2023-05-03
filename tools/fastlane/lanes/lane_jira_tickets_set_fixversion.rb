desc %{ gets all tickets since last tag and updates fix version for involved Jira tickets }
private_lane :lane_jira_tickets_set_fixversion do |options|

  jira_user = options[:jira_user]
  jira_token = options[:jira_token]
  jira_url = options[:jira_url]
  jira_ticket_prefix = options[:jira_ticket_prefix]

  previous_tag = sh("git", "describe", "--tags", "--abbrev=0", "--match=Picnic*").strip

  version = flutter_version(
    pubspec_location: '../pubspec.yaml',
  )['version_name']

  issues = jira_issue_keys_from_changelog(
    tag: previous_tag.shellescape,
    project_key: jira_ticket_prefix,
  )

  issues -= ["GS-0"]

  # fix default invalid path
  JIRA::Client::DEFAULT_OPTIONS[:context_path] = ""

  set_jira_fix_version(
    url: jira_url,
    username: jira_user,
    password: jira_token,
    # auth_type: :basic, # it should be a symbol but action forces a string here, default value is what we need actually
    # use_cookies: false, # same thing
    project_key: jira_ticket_prefix,
    version_name: "FE - v#{version}",
    issue_ids: issues,
  )
end
