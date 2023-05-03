require 'tempfile'
require 'open3'

INTERMEDIATE_CERTIFICATES = [
  {
    OU: 'G1',
    url: 'https://www.apple.com/certificateauthority/DeveloperIDCA.cer'
  },
  {
    OU: 'G2',
    url: 'https://www.apple.com/certificateauthority/DeveloperIDG2CA.cer'
  },
]

module Fastlane
  module Actions
    module SharedValues
      MAC_INTERMEDIATE_CERT_CUSTOM_VALUE = :MAC_INTERMEDIATE_CERT_CUSTOM_VALUE
    end

    class MacIntermediateCertAction < Action
      def self.run(params)
        INTERMEDIATE_CERTIFICATES.each do |c|
          cert_url = c[:url]

          file = Tempfile.new(File.basename(cert_url))
          filename = file.path

          import_command = "curl -f -o #{filename} #{cert_url} && security import #{filename}"

          # Executes command
          stdout, stderr, status = Open3.capture3(import_command)
          unless status.success?
            unless /The specified item already exists in the keychain./ =~ stderr
              UI.user_error!("Could not install certificate")
              UI.command_output(stdout)
              UI.command_output(stderr)
            end
            UI.verbose("The Certificate was already installed")
            return true
          end
        end
      end


      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Fetch and installs all intermediate certificates."
      end

      def self.details
        "You can use this action to install all intermediate certificates which are required to build the signing certificate chain."
      end

      def self.available_options
        []
      end

      def self.authors
        ["phani92", "r3nic1e"]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end
    end
  end
end
