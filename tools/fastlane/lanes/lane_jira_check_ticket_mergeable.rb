desc %{ checks whether ticket is mergeable }
private_lane :lane_jira_check_ticket_mergeable do |options|

  branch = options[:branch]
  jira_user = options[:jira_user]
  jira_token = options[:jira_token]
  jira_url = options[:jira_url]
  jira_ticket_prefix = options[:jira_ticket_prefix]
  release_type = options[:release_type]
  pull_request_title = options[:pull_request_title]

  tickets = jira_tickets(
    jira_ticket_prefix: jira_ticket_prefix,
    branch: branch,
    release_type: release_type,
    pull_request_title: pull_request_title,
  )

  if tickets.length != 1 then
    UI.user_error! "cannot determine corresponding ticket (one of #{tickets})"
  end

  ticket = tickets[0]

  ticket_details = get_jira_issue(
    username: jira_user,
    api_token: jira_token,
    site: jira_url,
    issue_key: ticket,
  )

  unless ticket_details["fields"]["resolution"].nil?
    UI.success "Ticket is resolved"
    next
  end

  is_devops = false
  ticket_details["fields"]["components"].each do |component|
    if component["name"] == "DevOps" then
      is_devops = true
      break
    end
  end

  if is_devops then
    UI.success "DevOps tasks are about CI, no QA required"
    next
  end

  status = ticket_details["fields"]["status"]

  if ticket_details["fields"]["issuetype"]["name"] == "Epic"
    if ["Ready for Deployment", "Done"].include?(status["name"])
      UI.success "Epic is #{status["name"]}"
      next
    else
      UI.user_error! "Epic in status #{status['name']} cannot be merged"
    end
  else
    if ["Business Review", "Waiting for Deployment", "Done"].include?(status["name"])
      UI.success "Issue is in #{status["name"]}"
      next
    else
      UI.user_error! "Issue in status #{status['name']} cannot be merged"
    end
  end
end
