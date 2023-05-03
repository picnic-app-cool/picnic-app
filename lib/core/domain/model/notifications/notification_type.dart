enum NotificationType {
  glitterbomb('glitterbomb'),
  follow('follow'),
  postComment('post_comment'),
  commentReaction('comment_reaction'),
  postReaction('post_reaction'),
  messageReply('message_reply'),
  message('message'),
  seedsReceived('seeds_received'),
  postShared('post_shared'),
  postSaved('post_saved'),
  postReportedModerator('post_reported_to_circle_moderators'),
  bannedFromCircle('user_banned_from_circle'),
  unbannedFromCircle('user_unbanned_from_circle'),
  bannedFromApp('user_banned_from_app'),
  unbannedFromApp('user_unbanned_from_app'),
  postRemovedModerator('post_removed_by_moderator'),
  postRemovedPicnic('post_removed_by_picnic'),
  electionAboutToLose('election_about_to_lose'),
  electionSomeonePassed('election_someone_passed'),
  circle('circle'),
  post('post'),
  profile('profile'),
  user('user'),
  userJoinedACircle("user_joined_a_circle"),
  userInvitedToACircle("user_invited_to_a_circle"),
  unknown('');

  final String value;

  const NotificationType(this.value);

  static NotificationType fromString(String value) => NotificationType.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => NotificationType.unknown,
      );
}
