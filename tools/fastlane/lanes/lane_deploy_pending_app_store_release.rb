desc %{ prepares release notes based on JIRA tickets in commits since the last release,
uploads the build to firebase and adds a JIRA comment to every mentioned issue with build
 version, link to bitrise and link to firebase }
private_lane :lane_deploy_pending_app_store_release do |options|
  api_key = Base64.decode64(IOS_APPSTORECONNECT_API_KEY)
  app_store_connect_api_key(
    key_id: IOS_KEY_ID,
    issuer_id: IOS_KEY_ISSUER_ID,
    key_content: api_key,
    duration: 1200, # optional (maximum 1200)
    in_house: false # optional but may be required if using match/sigh
  )
  deploy_pending_app_store_release
end
