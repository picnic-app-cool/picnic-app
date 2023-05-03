enum SecureLocalStorageKey {
  gqlAccessToken("GQL_ACCESS_TOKEN"),
  gqlRefreshToken("GQL_REFRESH_TOKEN"),
  environmentConfig("ENVIRONMENT_CONFIG"),
  //TODO remove this from here and move to separate storage that is accessible from isolate
  additionalGraphQLHeaders("ADDITIONAL_GRAPHQL_HEADERS"),
  featureFlags("FEATURE_FLAGS");

  const SecureLocalStorageKey(this.value);

  final String value;
}
