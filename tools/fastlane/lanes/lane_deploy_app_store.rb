desc %{ promotes latest testflight build to appstore }
private_lane :lane_deploy_app_store do |options|

  submit_for_review = options.fetch(:submit_for_review, false)
  automatic_release = options.fetch(:automatic_release, false)
  skip_metadata = options.fetch(:skip_metadata, false)
  skip_screenshots = options.fetch(:skip_screenshots, false)

  key_issuer_id = options[:key_issuer_id]
  key_id = options[:key_id]
  appstoreconnect_api_key = options[:appstoreconnect_api_key]

  api_key = Base64.decode64(appstoreconnect_api_key)
  app_store_connect_api_key(
    key_id: key_id,
    issuer_id: key_issuer_id,
    key_content: api_key,
    duration: 1200, # optional (maximum 1200)
    in_house: false # optional but may be required if using match/sigh
  )

  setup_ci

  last_build = latest_testflight_build_number

  deliver(
    app_version: lane_context[SharedValues::LATEST_TESTFLIGHT_VERSION],
    build_number: last_build.to_s,
    submit_for_review: submit_for_review,
    automatic_release: automatic_release,
    run_precheck_before_submit: false,
    force: true,
    reject_if_possible: true,
    skip_metadata: skip_metadata,
    skip_screenshots: skip_screenshots,
    overwrite_screenshots: !skip_screenshots,
    skip_binary_upload: true,
    precheck_include_in_app_purchases: false,
    submission_information: {
      add_id_info_uses_idfa: false,
      add_id_info_serves_ads: false,
      add_id_info_tracks_install: true,
      add_id_info_tracks_action: true,
      add_id_info_limits_tracking: true,
    }
  )

end