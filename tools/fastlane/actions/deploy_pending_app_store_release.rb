require "fastlane/action"
require "spaceship"

module Fastlane
  module Actions
    class DeployPendingAppStoreReleaseAction < Action

      def self.run(params)
        begin
          app_id = params[:app_identifier] ||= CredentialsManager::AppfileConfig.try_fetch_value(:app_identifier)
          unless app_id
            UI.user_error!("Could not find app_id")
          end

          token = self.api_token
          if token
            UI.message("Using App Store Connect API token...")
            Spaceship::ConnectAPI.token = token
          end

          app = Spaceship::ConnectAPI::App.find(app_id)
          version = app.get_app_store_versions.first
          UI.message("app_store_state is #{version.app_store_state}")
          client ||= Spaceship::ConnectAPI
          platform ||= Spaceship::ConnectAPI::Platform::IOS
          filter = {
            appStoreState: [
              Spaceship::ConnectAPI::AppStoreVersion::AppStoreState::PENDING_DEVELOPER_RELEASE
            ].join(","),
            platform: platform
          }

          app_store_version = app.get_app_store_versions(client: client, filter: filter, includes: "appStoreVersionSubmission")
                                 .sort_by { |v| Gem::Version.new(v.version_string) }
                                 .last
          if app_store_version
            version_string = app_store_version.version_string
            state = app_store_version.app_store_state
            UI.message("version #{version_string} is #{state}")
            unless state == Spaceship::ConnectAPI::AppStoreVersion::AppStoreState::PENDING_DEVELOPER_RELEASE
              UI.user_error!("AppStoreState is not PENDING_DEVELOPER_RELEASE")
            end

            release_version_if_possible(app: app, app_store_version: app_store_version, token: token)
          else
            UI.user_error!("no pending release version exist")
          end
        rescue => error
          UI.user_error!("The deploy_pending_release action is finished with error: #{error.message}!")
        end
      end

      def self.release_version_if_possible(app: nil, app_store_version: Spaceship::ConnectAPI::AppStoreVersion, token: nil)
        unless app
          UI.user_error!("Could not find app with bundle identifier '#{params[:app_identifier]}' on account #{params[:username]}")
        end

        version = app.get_pending_release_app_store_version
        if version.nil? == false
          Spaceship::ConnectAPI.post_app_store_version_release_request(app_store_version_id: version.id)
          UI.message("release version #{app_store_version} successfully!")
        else
          UI.user_error!("version not found while releasing version #{app_store_version}, #{e.message}\n#{e.backtrace.join("\n")}")
        end
      end

      def self.api_token
        api_key = Actions.lane_context[SharedValues::APP_STORE_CONNECT_API_KEY]
        api_token ||= Spaceship::ConnectAPI::Token.create(api_key)
        return api_token
      end

      def self.description
        "release if status is Pending Developer Release."
      end

      def self.return_value
        return "'Success' if action passes, else, 'Nothing has changed'"
      end

      def self.details
        "use fastlane to release or reject reviewed version"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :app_identifier,
                                       short_option: "-a",
                                       env_name: "app_identifier",
                                       description: "The bundle identifier of your app",
                                       optional: true,
                                       code_gen_sensitive: true,
                                       default_value: CredentialsManager::AppfileConfig.try_fetch_value(:app_identifier),
                                       default_value_dynamic: true),
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        [:ios, :mac].include?(platform)
      end

      def self.example_code
        [
          'deploy_pending_release(
            api_key: "api_key" # your app_store_connect_api_key
          )'
        ]
      end
    end
  end
end