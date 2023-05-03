module Fastlane
  module Actions

    class FirebaseReleaseCommentAction < Action
      def self.run(params)
        build_url = params[:build_url]
        platform = params[:platform]
        release_url = params[:release_url]
        display_version = params[:display_version]
        build_version = params[:build_version]

        comment = "New #{platform} build available in firebase app distribution\n\n" +
          "*#{display_version} (#{build_version})*\n\n" +
          "*github build*\n#{build_url}\n\n" +
          "*firebase url*\n#{release_url}"
        return comment
      end

      def self.description
        "prepares comment with firebase release info"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :build_url,
            description: "CI build URL",
            type: String,
          ),
          FastlaneCore::ConfigItem.new(
            key: :platform,
            description: "Platform (iOS or Android)",
            type: String,
          ),
          FastlaneCore::ConfigItem.new(
            key: :release_url,
            description: "Firebase release URL",
            type: String,
          ),
          FastlaneCore::ConfigItem.new(
            key: :display_version,
            description: "Firebase display version",
            type: String,
          ),
          FastlaneCore::ConfigItem.new(
            key: :build_version,
            description: "Firebase build number",
            type: Integer,
          ),
        ]
      end

      def self.return_value
        "comment contents for latest firebase release info"
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
