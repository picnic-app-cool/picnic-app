enum AnalyticsChangeTarget {
  mainTab('main_tab'),
  feedTab('feed_tab'),
  post('post'),
  chatFeedPage('chat_feed_page'),

  profileTab('profile_tab');

  final String value;

  const AnalyticsChangeTarget(this.value);
}
