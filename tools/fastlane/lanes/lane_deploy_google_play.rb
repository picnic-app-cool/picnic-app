desc %{ promotes latest alpha build to production }
private_lane :lane_deploy_google_play do |options|

  setup_ci
  json_key = ENV["PICNIC_GOOGLE_PLAY_KEY_DATA"]
  json_key = Base64.decode64(json_key)

  rollout = 1 # 100%

  upload_to_play_store(
    rollout: rollout.to_s,
    track: 'alpha',
    track_promote_to: 'production',
    json_key_data: json_key,
    skip_upload_metadata: true,
    skip_upload_images: true,
    skip_upload_changelogs: true,
    skip_upload_screenshots: true,
  )
end