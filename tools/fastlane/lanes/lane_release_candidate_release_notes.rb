desc %{ prepares release notes based on JIRA tickets in commits since the last release
and adds a JIRA comment to every mentioned issue with build }
private_lane :lane_release_candidate_release_notes do |options|

  branch = options[:branch]
  jira_url = options[:jira_url]
  jira_user = options[:jira_user]
  jira_token = options[:jira_token]
  jira_ticket_prefix = options[:jira_ticket_prefix]
  release_type = options[:release_type]

  last_release_tag_name = sh("git", "describe", "--tags", "--abbrev=0").strip

  tickets = jira_tickets(
    jira_ticket_prefix: jira_ticket_prefix,
    branch: branch,
    last_release_tag_name: last_release_tag_name,
    release_type: release_type,
  )

  tickets, release_notes = release_notes_from_jira_tickets(
    tickets: tickets,
    jira_user: jira_user,
    jira_token: jira_token,
    jira_url: jira_url,
    release_type: release_type,
    branch: branch,
  )

  File.open(options[:out_file], 'w') do |f|
    f.write(release_notes)
  end
end