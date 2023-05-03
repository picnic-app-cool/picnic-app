desc %{ prepares release notes based on JIRA tickets in commits since the last release,
uploads the build to firebase and adds a JIRA comment to every mentioned issue with build
 version, link to bitrise and link to firebase }
private_lane :lane_deploy_firebase do |options|

  app_id = options[:app_id]
  jira_url = options[:jira_url]
  jira_user = options[:jira_user]
  jira_token = options[:jira_token]
  firebase_token = options[:firebase_token]
  firebase_testers_group_prefix = options[:firebase_testers_group_prefix]
  ipa_path = options[:ipa_path]
  build_url = options[:build_url]
  platform = options[:platform]
  android_artifact_type = options[:android_artifact_type]
  android_artifact_path = options[:android_artifact_path]
  branch = options[:branch]
  jira_ticket_prefix = options[:jira_ticket_prefix]
  pull_request_title = options[:pull_request_title]
  pull_request_number = options[:pull_request_number]

  develop_release_tag_name = "latest-firebase-release-develop-"+ platform

  ## Retrives the type of release based on the current branch
  release_type = get_release_type(
    branch: branch,
  )

  puts "release type: " + release_type.to_s

  setup_ci

  last_release_tag_name = release_type == :develop ? develop_release_tag_name : ''

  tickets = jira_tickets(
    jira_ticket_prefix: jira_ticket_prefix,
    branch: branch,
    last_release_tag_name: last_release_tag_name,
    release_type: release_type,
    pull_request_title: pull_request_title,
  )

  tickets, release_notes = release_notes_from_jira_tickets(
    tickets: tickets,
    jira_user: jira_user,
    jira_token: jira_token,
    jira_url: jira_url,
    release_type: release_type,
    branch: branch,
    pull_request_title: pull_request_title,
    pull_request_number: pull_request_number,
  )

  case release_type
  when :develop, :main, :release, :feature
    firebase_testers_group = firebase_testers_group_prefix
  else
    firebase_testers_group = firebase_testers_group_prefix + "_developers"
  end

  puts "\n\nRELEASE NOTES:"
  puts "\n===============\n" + release_notes + "\n==============\n"

  puts "testers group: " + firebase_testers_group
  release = firebase_app_distribution(
    app: app_id,
    groups: firebase_testers_group,
    release_notes: release_notes,
    ipa_path: ipa_path,
    firebase_cli_token: firebase_token,
    android_artifact_type: android_artifact_type,
    android_artifact_path: android_artifact_path,
  )

  if release_type == :develop
    add_git_tag(
      tag: develop_release_tag_name,
      force: true,
    )
    push_git_tags(
      tag: develop_release_tag_name,
      force: true,
    )
  end

  if pull_request_number.to_i > 0
    github_api(
      api_bearer: ENV['GITHUB_TOKEN'],
      http_method: "POST",
      path: "/repos/#{ENV['GITHUB_REPO']}/issues/#{pull_request_number}/comments",
      body: {
        body: "Deployment #{platform} to QA succeeded, build: #{release[:displayVersion]} (#{release[:buildVersion]})"
      },
    )
  end

  comment = firebase_release_comment(
    build_url: build_url,
    platform: platform,
    release_url: release[:testingUri],
    display_version: release[:displayVersion],
    build_version: release[:buildVersion],
  )

  tickets.each do |elem|
    jira(
      url: jira_url,
      username: jira_user,
      password: jira_token,
      ticket_id: elem,
      comment_text: comment
    )
  end
end
