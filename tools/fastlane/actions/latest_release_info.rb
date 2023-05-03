module Fastlane
  module Actions

    class LatestReleaseInfoAction < Action
      def self.run(params)

        build_info = other_action.firebase_app_distribution_get_latest_release(
          app: params[:app_id],
          firebase_cli_token: params[:firebase_token],
          debug: true,
        )
        release_id = build_info[:name].match("releases/(.+)")[1]
        release_url = "https://appdistribution.firebase.google.com/testerapps/#{params[:app_id]}/releases/#{release_id}"
        release_commit_hash = build_info[:releaseNotes][:text].lines.first.strip
        unless release_commit_hash.match?(/b[0-9a-f]{5,40}\b/)
          release_commit_hash = "HEAD~3"
        end

        build_info[:release_id] = release_id
        build_info[:release_url] = release_url
        build_info[:release_commit_hash] = release_commit_hash
        return build_info
      end

      def self.description
        "Retrieves info about latest release from Firebase"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :app_id,
            description: "firebase app's id",
            type: String
          ),
          FastlaneCore::ConfigItem.new(
            key: :firebase_token,
            description: "firebase token",
            type: String
          ),
          FastlaneCore::ConfigItem.new(
            key: :release_type,
            description: "type of release (develop, main, release, feature, unknown)",
            type: Symbol,
            optional: false,
            ),
        ]
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
