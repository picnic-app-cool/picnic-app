module Fastlane
  module Actions
    class CreateFeatureBranchAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        jira_user = params[:jira_user]
        jira_token = params[:jira_token]
        jira_url = params[:jira_url]
        main_branch_name = 'develop'

        other_action.ensure_git_status_clean

        jira_ticket_number = other_action.prompt(
          text: "JIRA epic number (e.g: GS-123): "
        )
        if jira_token
          issue = other_action.get_jira_issue(
            username: jira_user,
            api_token: jira_token,
            site: jira_url,
            issue_key: jira_ticket_number
          )
          if !issue or !issue["fields"] or !issue["fields"]["summary"]
            UI.user_error!("specified issue does not exist: " + jira_ticket_number)
          end
          name = issue["fields"]["summary"].strip
        else
          name = other_action.prompt(
            text: "feature name: ",
          )
        end

        puts "name: '" + name + "'"
        normalized_name = name.gsub(/[^a-zA-Z0-9]/, '-')[0..30].downcase
        puts "normalized name: '" + normalized_name + "'"
        sh("git fetch origin " + main_branch_name)
        branch_name = "feature/" + jira_ticket_number + "/" + normalized_name
        sh("git checkout -b " + branch_name + " origin/" + main_branch_name + " --no-track")
        sh("git push -u origin " + branch_name)
        UI.success("Successfully created '" + branch_name + "' feature branch and pushed to origin")
      end

      def self.description
        "prepares comment with firebase release info"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :jira_user,
            description: "username for jira",
            type: String,
            optional: true,
          ),
          FastlaneCore::ConfigItem.new(
            key: :jira_token,
            description: "api token for jira",
            type: String,
            optional: true,
          ),
          FastlaneCore::ConfigItem.new(
            key: :jira_url,
            description: "url for jira",
            type: String,
            optional: true,
          ),
        ]
      end

      def self.return_value
        "creates new feature branch for specified JIRA ticket"
      end

      def self.authors
        ["andrzejchm"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
