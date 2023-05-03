module Fastlane
  module Actions

    class ReleaseNotesFromJiraTicketsAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        tickets = params[:tickets]
        jira_user = params[:jira_user]
        jira_token = params[:jira_token]
        jira_url = params[:jira_url]
        branch = params[:branch]
        release_type = params[:release_type]
        pull_request_title = params[:pull_request_title]
        pull_request_number = params[:pull_request_number]
        include_branch_and_tag_info = params[:include_branch_and_tag_info]

        new_tickets = tickets.dup
        tickets_details = other_action.get_jira_issue(
          username: jira_user,
          api_token: jira_token,
          site: jira_url,
          issue_key: tickets.join(" ").strip
        )

        release_notes = tickets.map do |elem|
          key = elem.strip
          if !tickets_details
            fields = nil
          elsif tickets_details["fields"]
            fields = tickets_details["fields"]
          elsif tickets_details[key]
            fields = tickets_details[key]["fields"]
          else
            fields = nil
          end
          unless fields
            new_tickets.delete(elem)
            next nil
          end
          value = key + ": " + fields["summary"]

          if fields["issuetype"]["name"] == "Sub-task"
            parent_key = fields["parent"]["key"]
            new_tickets.append(parent_key)
            next fields["parent"]["key"] + ": " + fields["parent"]["fields"]["summary"] + "\n\\__ " + value
          else
            next value
          end
        end
                               .compact
                               .join("\n")
        commit = other_action.last_git_commit

        case release_type
        when :develop
          emoji = '🚧 '
        when :main
          emoji = '🚀 '
        when :release
          emoji = '🎉 '
        when :feature
          emoji = '💡 '
        else
          emoji = '❓ '
        end

        branch = emoji + "branch: " + branch
        tag = sh("git tag --points-at HEAD").strip
        if !tag or tag.empty?
          tag = ""
        else
          tag = "\ntag: " + tag
        end
        pull_request = ''
        if (pull_request_number && !pull_request_number.empty?) || (pull_request_title && !pull_request_title.empty?)
          pull_request = "\npull request: ##{pull_request_number} - #{pull_request_title}"
        end
        release_notes = (include_branch_and_tag_info ? (branch + tag + pull_request + "\n\n") : '') +
          release_notes +
          "\n" +
          "commit hash:\n" +
          commit[:commit_hash]

        return new_tickets.uniq, release_notes

      end

      def self.description
        "Retrieves latest JIRA ticket numbers based on recent git commit messages"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :tickets,
            description: "jira ticket numbers list", # a short description of this parameter
            type: Array,
            optional: false,
          ),
          FastlaneCore::ConfigItem.new(
            key: :jira_user,
            description: "username for jira",
            type: String,
            optional: false,
          ),
          FastlaneCore::ConfigItem.new(
            key: :branch,
            description: "current git branch",
            type: String,
            optional: false,
          ),
          FastlaneCore::ConfigItem.new(
            key: :pull_request_number,
            description: "number of current pull request, if any",
            type: String,
            optional: true,
          ),
          FastlaneCore::ConfigItem.new(
            key: :pull_request_title,
            description: "title of current pull request, if any",
            type: String,
            optional: true,
          ),
          FastlaneCore::ConfigItem.new(
            key: :release_type,
            description: "release type",
            type: Symbol,
            optional: false,
          ),
          FastlaneCore::ConfigItem.new(
            key: :include_branch_and_tag_info,
            description: "whether to include branch name and git tags in release notes",
            type: Boolean,
            default_value: true,
          ),
          FastlaneCore::ConfigItem.new(
            key: :jira_token,
            description: "api token for jira",
            type: String,
          ),
          FastlaneCore::ConfigItem.new(
            key: :jira_url,
            description: "url for jira",
            type: String,
            optional: false,
          ),
        ]
      end

      def self.return_value
        "tickets array appended with parent tickets AND release notes off of JIRA ticket numbers"
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