desc %{ prepares release notes based on JIRA tickets in commits since the last release,
uploads the build to firebase }
private_lane :lane_deploy_google_alpha do |options|

  android_artifact_path = options[:android_artifact_path]

  setup_ci
  json_key = ENV["PICNIC_GOOGLE_PLAY_KEY_DATA"]
  json_key = Base64.decode64(json_key)

  upload_to_play_store(
    track: 'alpha',
    aab: android_artifact_path,
    json_key_data: json_key,
  )
end