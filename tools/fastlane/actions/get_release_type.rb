module Fastlane
  module Actions

    class GetReleaseTypeAction < Action
      def self.run(params)
        branch = params[:branch]
        case branch
        when /^develop$/
          return :develop
        when /^main$/
          return :main
        when /^(release|hotfix)\/.*$/
          return :release
        else
          return :feature
        end

      end

      def self.description
        "Determines release type based on the branch"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :branch,
            description: "current git branch from which the release happens",
            type: String,
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
