desc %{ uploads the build to testflight }
private_lane :lane_deploy_testflight do |options|

  ipa_path = options[:ipa_path]
  jira_url = options[:jira_url]
  jira_user = options[:jira_user]
  jira_token = options[:jira_token]
  jira_ticket_prefix = options[:jira_ticket_prefix]
  branch = options[:branch]
  key_issuer_id = options[:key_issuer_id]
  key_id = options[:key_id]
  appstoreconnect_api_key = options[:appstoreconnect_api_key]

  api_key = Base64.decode64(appstoreconnect_api_key)
  app_store_connect_api_key(
    key_id: key_id,
    issuer_id: key_issuer_id,
    key_content: api_key,
    duration: 1200, # optional (maximum 1200)
    in_house: false # optional but may be required if using match/sigh
  )

  release_type = :main

  tickets = jira_tickets(
    jira_ticket_prefix: jira_ticket_prefix,
    branch: branch,
    last_release_tag_name: '',
    release_type: release_type,
  )

  _, release_notes = release_notes_from_jira_tickets(
    tickets: tickets,
    jira_user: jira_user,
    jira_token: jira_token,
    jira_url: jira_url,
    release_type: release_type,
    branch: branch,
    include_branch_and_tag_info: false,
  )

  setup_ci

  puts "RELEASE NOTES:\n============\n" + release_notes + "\n============\n"

  upload_to_testflight(
    ipa: ipa_path,
    skip_waiting_for_build_processing: false,
    distribute_external: true,
    changelog: release_notes,
    groups: ['Picnic Beta Testers']
  )

end