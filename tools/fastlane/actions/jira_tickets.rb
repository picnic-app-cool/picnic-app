module Fastlane
  module Actions

    class JiraTicketsAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        branch = params[:branch]
        release_type = params[:release_type]
        pr_title = params[:pull_request_title] || ''
        regex = "(" + params[:jira_ticket_prefix] + "-\\d+)"
        case release_type
        when :feature
          # we dont want to get list of commits from feature branch as there is a lot of noise after merging in `main`
          # branch. we will only include the feature branch' JIRA ticket instead
          since_commit = "HEAD"
        when :develop
          begin
            since_commit = sh("git", "rev-list", "-n", "1", params[:last_release_tag_name]).strip
          rescue
            since_commit = "HEAD~5"
          end
        else
          since_commit = "HEAD~5"
        end

        puts "Retrieving changelog for commits between '" + since_commit + "' and 'HEAD'..."
        commit_messages = other_action.changelog_from_git_commits(
          between: [since_commit, "HEAD"],
          merge_commit_filtering: "exclude_merges",
          quiet: false
        )

        if commit_messages
          commit_messages = pr_title + "\n" + branch + "\n" + commit_messages
        else
          commit_messages = pr_title + branch
        end
        return commit_messages
                 .split("\n")
                 .select do |elem|
          !elem.match(regex).nil?
        end
                 .map do |elem|
          elem.match(regex)[0]
        end.uniq

      end

      def self.description
        "Retrieves latest JIRA ticket numbers based on recent git commit messages"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :since_commit,
            description: "commit from which to start the diff until HEAD", # a short description of this parameter
            type: String
          ),
          FastlaneCore::ConfigItem.new(
            key: :jira_ticket_prefix,
            description: "Jira ticket prefix, i.e: for tickets GS-127 use 'GS' prefix",
            type: String, # true: verifies the input is a string, false: every kind of value
            optional: false,
          ),
          FastlaneCore::ConfigItem.new(
            key: :branch,
            description: "current git branch from which the release happens",
            type: String,
            optional: false,
          ),
          FastlaneCore::ConfigItem.new(
            key: :last_release_tag_name,
            description: "last release's tag name to determine the commit of previous release",
            type: String,
            optional: false,
          ),
          FastlaneCore::ConfigItem.new(
            key: :pull_request_title,
            description: "title of the pull request",
            type: String,
            optional: true,
          ),
          FastlaneCore::ConfigItem.new(
            key: :release_type,
            description: "type of release (develop, main, release, feature, unknown)",
            type: Symbol,
            optional: false,
          ),
        ]
      end

      def self.return_value
        "list of ticket numbers from last N commits"
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
