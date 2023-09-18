import 'dart:collection';

import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/data/graphql/upload_file_size.dart';
import 'package:picnic_app/core/domain/device_platform.dart';
import 'package:picnic_app/core/domain/model/app_info.dart';
import 'package:picnic_app/core/domain/model/auth_result.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/core/domain/model/chat_member.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_moderation_type.dart';
import 'package:picnic_app/core/domain/model/circle_permissions.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/circle_stats.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/collection_counter.dart';
import 'package:picnic_app/core/domain/model/contact_phone_number.dart';
import 'package:picnic_app/core/domain/model/country_with_dial_code.dart';
import 'package:picnic_app/core/domain/model/device_system_info.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags_defaults.dart';
import 'package:picnic_app/core/domain/model/group_with_circles.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/core/domain/model/link_url.dart';
import 'package:picnic_app/core/domain/model/notify_type.dart';
import 'package:picnic_app/core/domain/model/onboarding_circles_section.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/phone_contacts/phone_contact.dart';
import 'package:picnic_app/core/domain/model/phone_contacts/phone_contact_data.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/core/domain/model/slice_role.dart';
import 'package:picnic_app/core/domain/model/upload_attachment.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/domain/model/user_contact.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/core/domain/model/version_control_info.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_excerpt.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_input.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_reaction.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_sender.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_status.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_type.dart';
import 'package:picnic_app/features/chat/domain/model/chat_messages_feed.dart';
import 'package:picnic_app/features/chat/domain/model/chat_role.dart';
import 'package:picnic_app/features/chat/domain/model/chat_settings.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';
import 'package:picnic_app/features/chat/domain/model/unread_chat.dart';
import 'package:picnic_app/features/chat/domain/use_cases/chat_messages_use_case.dart';
import 'package:picnic_app/features/chat/message_actions/model/message_actions_open_event.dart';
import 'package:picnic_app/features/circles/circle_details/models/posts_sorting_type.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config_type.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member_custom_roles.dart';
import 'package:picnic_app/features/circles/domain/model/circle_visibility.dart';
import 'package:picnic_app/features/circles/domain/model/comment_report.dart';
import 'package:picnic_app/features/circles/domain/model/message_report.dart';
import 'package:picnic_app/features/circles/domain/model/permanent_banned_user.dart';
import 'package:picnic_app/features/circles/domain/model/royalty.dart';
import 'package:picnic_app/features/circles/domain/model/slice_member.dart';
import 'package:picnic_app/features/circles/domain/model/temporary_banned_user.dart';
import 'package:picnic_app/features/create_circle/domain/model/create_circle_form.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';
import 'package:picnic_app/features/onboarding/domain/model/interest.dart';
import 'package:picnic_app/features/onboarding/domain/model/list_groups_input.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';
import 'package:picnic_app/features/posts/domain/model/link_metadata.dart';
import 'package:picnic_app/features/posts/domain/model/poll_answer.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/link_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/link_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/poll_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_report.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/domain/model/posts/content_stats_for_content.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';
import 'package:picnic_app/features/posts/domain/model/text_post_color.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_follow.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_glitterbomb.dart';
import 'package:picnic_app/features/reports/domain/model/report_reason.dart';
import 'package:picnic_app/features/reports/domain/model/resolve_status.dart';
import 'package:picnic_app/features/seeds/domain/model/director_vote.dart';
import 'package:picnic_app/features/seeds/domain/model/election_candidate.dart';
import 'package:picnic_app/features/seeds/domain/model/governance.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';
import 'package:picnic_app/features/seeds/domain/model/seed_holder.dart';
import 'package:picnic_app/features/seeds/domain/model/vote_candidate.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason.dart';
import 'package:picnic_app/features/settings/domain/model/notification_settings.dart';
import 'package:picnic_app/features/settings/domain/model/privacy_settings.dart';
import 'package:picnic_app/features/settings/domain/model/user_settings.dart';
import 'package:picnic_app/features/slices/domain/model/slice_settings.dart';
import 'package:picnic_app/resources/assets.gen.dart';

import '../test_utils/test_utils.dart';

class Stubs {
  static CreateCircleForm get createCircleForm => CreateCircleForm(
        emoji: '😀',
        name: 'roblox',
        description: 'some text goes here!!!',
        language: const Language.empty().copyWith(
          title: 'english',
        ),
        group: const GroupWithCircles.empty().copyWith(
          id: const Id('1'),
          name: 'gaming',
          circles: [const BasicCircle.empty().copyWith(name: 'roblox', emoji: '🚀')],
        ),
        visibility: CircleVisibility.opened,
        image: '',
        userSelectedNewImage: false,
        userSelectedNewCover: false,
        coverImage: '',
      );

  static CreatePostInput get createTextPostInput => CreatePostInput(
        circleId: circle.id,
        sound: sound1,
        content: TextPostContentInput(
          additionalText: (textPost.content as TextPostContent).additionalText,
          text: (textPost.content as TextPostContent).text,
          color: TextPostColor.blue,
        ),
      );

  static CreatePostInput get createImagePostInput => CreatePostInput(
        circleId: circle.id,
        sound: sound1,
        content: const ImagePostContentInput(
          text: 'image caption text',
          imageFilePath: 'local_path/to_image.png',
        ),
      );

  static CreatePostInput get createVideoPostInput => CreatePostInput(
        circleId: circle.id,
        sound: sound1,
        content: const VideoPostContentInput(
          text: 'video caption text',
          videoFilePath: 'local_path/to_video.mp4',
        ),
      );

  static CreatePostInput get createLinkPostInput => CreatePostInput(
        circleId: circle.id,
        sound: sound1,
        content: const LinkPostContentInput(
          linkUrl: LinkUrl('https://picnic.zone'),
        ),
      );

  static User get user => const User.empty().copyWith(
        id: const Id("user-id-payamdaliri"),
        username: 'payamdaliri',
        profileImageUrl: const ImageUrl('https://example.com/image.jpg'),
        isVerified: false,
      );

  static DateTime get dateTime => DateTime(2022, 12, 7);

  static PublicProfile get publicProfile => const PublicProfile.empty().copyWith(user: user);

  static PublicProfile get publicProfile2 => const PublicProfile.empty().copyWith(user: user2);

  static BasicPublicProfile get postAuthor => BasicPublicProfile.fromPublicProfile(publicProfile);

  static PrivateProfile get privateProfile => const PrivateProfile.empty().copyWith(user: user, languages: ['en']);

  static UserMention get userMention => const UserMention.empty();

  static UnreadChat get unreadChat => UnreadChat(
        chatId: chat.id,
        chatType: ChatType.group,
        lastMessageAtString: '2023-02-07T03:47:52Z',
        unreadMessagesCount: 0,
      );

  static FeatureFlags get featureFlags => FeatureFlags.defaultFlags(const FeatureFlagsDefaults())
      .enable(FeatureFlagType.collectionsEnabled)
      .enable(FeatureFlagType.royaltyTabEnabled)
      .enable(FeatureFlagType.areSeedsEnabled)
      .enable(FeatureFlagType.seedsProfileCircleEnabled)
      .enable(FeatureFlagType.sendCirclePushEnabled)
      .enable(FeatureFlagType.chatInputElectricEnabled)
      .enable(FeatureFlagType.chatInputAttachmentEnabled)
      .enable(FeatureFlagType.chatSettingOnlineUsersEnabled)
      .enable(FeatureFlagType.savedPostsEnabled)
      .enable(FeatureFlagType.commentAttachmentEnabled)
      .enable(FeatureFlagType.commentInstantCommandsEnabled)
      .enable(FeatureFlagType.pollPostCreationEnabled)
      .enable(FeatureFlagType.linkPostCreationEnabled)
      .enable(FeatureFlagType.textPostCreationEnabled)
      .enable(FeatureFlagType.postOverlayCommentsEnabled)
      .enable(FeatureFlagType.imagePostCreationEnabled)
      .enable(FeatureFlagType.videoPostCreationEnabled)
      .enable(FeatureFlagType.tempBanEnabled)
      .enable(FeatureFlagType.searchBlacklistWordsEnabled)
      .disable(FeatureFlagType.attachSoundsToPostsEnabled)
      .enable(FeatureFlagType.followButtonOnDiscoverPageResultsEnabled)
      .disable(FeatureFlagType.nativeMediaPickerInPostCreationEnabled)
      .disable(FeatureFlagType.isCirclePrivacyDiscoverableEnabled)
      .enable(FeatureFlagType.manageRolesEnabled)
      .enable(FeatureFlagType.isMuteCircleEnabled)
      .enable(FeatureFlagType.phoneContactsSharingEnable)
      .disable(FeatureFlagType.showCirclePostSorting)
      .enable(FeatureFlagType.isFirebasePhoneAuthEnabled)
      .enable(FeatureFlagType.areTrendingPostsEnabled)
      .enable(FeatureFlagType.enableElectionCircularGraph)
      .enable(FeatureFlagType.circlesSeeMoreEnabled)
      .enable(FeatureFlagType.enableEectionCountDownWidget);

  static User get user2 => const User.empty().copyWith(
        id: const Id("user-id-andrzejchm"),
        username: 'andrzejchm',
        profileImageUrl: const ImageUrl('https://example.com/image.jpg'),
        isVerified: false,
      );

  static ChatMessage get textMessage => ChatMessage(
        id: const Id("id-of-message"),
        content: "some content of a message",
        chatMessageType: ChatMessageType.text,
        chatMessageStatus: ChatMessageStatus.viewed,
        chatMessageSender: ChatMessageSender.user,
        author: user,
        createdAtString: "2022-09-13T08:23:45Z",
        reactions: [messageReaction],
        member: const ChatMember.empty(),
      );

  static Chat get chat => Chat(
        name: "Andrzej",
        image: const ImageUrl.empty(),
        id: const Id("Andrzej1234"),
        notificationCount: 2,
        participantsCount: 2,
        circle: const BasicCircle.empty().copyWith(emoji: '🚀'),
        latestMessages: PaginatedList(
          items: [
            chatMessage,
            chatMessage,
            chatMessage,
          ],
          pageInfo: const PageInfo.empty(),
        ),
        chatType: ChatType.single,
        createdAtString: "2022-09-13T08:23:45Z",
        participants: const PaginatedList.empty(),
      );

  static BasicChat basicChat = chat.toBasicChat();

  static ChatExcerpt get chatExcerpt => ChatExcerpt(
        id: const Id("ChatExcerpt1234"),
        name: "ChatExcerpt 1",
        imageUrl: "https://picsum.photos/id/419/100",
        chatType: ChatType.single,
        language: 'english',
        participantsCount: 3,
        messages: chatMessages,
        circle: Stubs.circle,
      );

  static Circle circle = Circle(
    id: const Id("Circle1"),
    name: "Circle 1",
    description: "Circle 1 description",
    emoji: '🚀',
    rulesText: "",
    languageCode: "",
    membersCount: 1,
    shareLink: "https://picnic.zone/circle/Circle1",
    moderationType: CircleModerationType.director,
    circleRole: CircleRole.member,
    isBanned: false,
    iJoined: false,
    chat: const BasicChat.empty(),
    groupId: const Id("1"),
    isVerified: false,
    visibility: CircleVisibility.opened,
    reportsCount: 1,
    imageFile: '',
    configs: [
      const CircleConfig.empty().copyWith(type: CircleConfigType.photo, enabled: true),
      const CircleConfig.empty().copyWith(type: CircleConfigType.video, enabled: true),
      const CircleConfig.empty().copyWith(type: CircleConfigType.text, enabled: true),
      const CircleConfig.empty().copyWith(type: CircleConfigType.poll, enabled: true),
      const CircleConfig.empty().copyWith(type: CircleConfigType.link, enabled: true),
      const CircleConfig.empty().copyWith(type: CircleConfigType.chatting, enabled: true),
      const CircleConfig.empty().copyWith(type: CircleConfigType.comments, enabled: true),
    ],
    coverImage: '',
    permissions: const CirclePermissions.defaultPermissions(),
    roles: const CircleMemberCustomRoles.empty(),
  );

  static Circle circleWithPostingDisabled = Stubs.circle.copyWith(
    configs: [
      const CircleConfig.empty().copyWith(type: CircleConfigType.photo, enabled: false),
      const CircleConfig.empty().copyWith(type: CircleConfigType.video, enabled: false),
      const CircleConfig.empty().copyWith(type: CircleConfigType.text, enabled: false),
      const CircleConfig.empty().copyWith(type: CircleConfigType.poll, enabled: false),
      const CircleConfig.empty().copyWith(type: CircleConfigType.link, enabled: false),
    ],
  );

  static Circle get circleWithDirectorRole => circle.copyWith(circleRole: CircleRole.director);

  static BasicCircle basicCircle = circle.toBasicCircle();

  static PaginatedList<Circle> circles = PaginatedList.singlePage([circle]);
  static PaginatedList<BasicCircle> basicCircles = PaginatedList.singlePage([basicCircle]);

  static Circle get circleBanned => circle.copyWith(isBanned: true);

  static Chat get chatWithCircle => chat.copyWith(circle: circle.toBasicCircle());

  static Chat get disabledChat =>
      chat.copyWith(circle: circle.toBasicCircle().copyWith(configs: [getChatConfig(enabled: false)]));

  static Chat get chatWithCircleBanned => chat.copyWith(circle: circleBanned.toBasicCircle());

  static ChatMessage get chatMessage => const ChatMessage.empty().copyWith(
        author: user,
        chatMessageStatus: ChatMessageStatus.notViewed,
        content: 'Im loving Picnic 🍉, there are so many communities',
        createdAtString: "2021-12-23 11:47:00",
      );

  static ChatMessage get previousMessage => const ChatMessage.empty().copyWith(
        author: user,
        chatMessageStatus: ChatMessageStatus.notViewed,
        content: 'Hi',
        createdAtString: "2021-12-23 11:46:00",
      );

  static DisplayableChatMessage get displayableChatMessage => DisplayableChatMessage(
        isFirstInGroup: true,
        isLastInGroup: true,
        chatMessage: chatMessage,
        previousMessage: previousMessage,
      );

  static List<ChatMessage> get chatMessages => [
        chatMessage.copyWith(id: const Id("message_first"), author: user2),
        chatMessage.copyWith(id: const Id("message_second")),
        chatMessage.copyWith(id: const Id("message_third")),
      ];

  static Stream<PaginatedList<DisplayableChatMessage>> get displayableMessagesStream =>
      Stream<PaginatedList<DisplayableChatMessage>>.fromIterable([
        PaginatedList.singlePage(chatMessages).toDisplayableChatMessages(privateProfile: privateProfile),
      ]);

  static ChatSettings get chatSettings => const ChatSettings.empty().copyWith(
        isMuted: false,
      );

  static SliceSettings get sliceSettings => const SliceSettings.empty().copyWith(
        isMuted: false,
      );

  static ChatMessageReaction get messageReaction => const ChatMessageReaction.empty().copyWith(
        reactionType: messageReactionType,
        hasReacted: true,
        count: 7,
      );

  static ChatMessageReactionType get messageReactionType => ChatMessageReactionType.heart();

  static Feed get feed => const Feed.empty().copyWith(
        id: const Id("feed-id"),
        name: 'Popular',
      );

  static PaginatedList<Feed> get feedList => PaginatedList.singlePage(
        [
          const Feed.empty().copyWith(
            id: const Id("feed-id"),
            name: 'Popular',
          ),
          for (var i = 0; i < 10; i++)
            const Feed.empty().copyWith(
              id: Id("feed-$i"),
              name: 'Feed #$i',
              membersCount: i * 1000,
            ),
        ],
      );

  static UnmodifiableListView<Feed> get unmodifiableFeedList => UnmodifiableListView(feedList);

  static Stream<UnmodifiableListView<Feed>> get feedStream => const Stream.empty();

  static Seed get seed => const Seed.empty().copyWith(
        amountAvailable: 315,
        circle: const Circle.empty().copyWith(name: "gacha", emoji: '🍉'),
      );

  static UserSettings get userSettings => const UserSettings.empty().copyWith(
        shareLink: "https://picnic.zone/profile/payamdaliri",
        inviteLink: "https://picnic.zone/profile/payamdaliri",
      );

  static NotificationSettings get notificationSettings => const NotificationSettings.empty().copyWith();

  static Collection get collection {
    const counter = 3;
    return Collection(
      id: const Id('collectionId'),
      title: 'Super collection',
      description: 'This is a super collection',
      counters: const CollectionCounter(posts: counter),
      createdAt: Stubs.dateTime.toIso8601String(),
      isPublic: true,
      owner: Stubs.publicProfile,
      previewPosts: List.filled(
        counter,
        const Post.empty().copyWith(
          id: const Id('1'),
          title: 'post title',
          content: const ImagePostContent.empty().copyWith(
            imageUrl: const ImageUrl(
              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/fairytale-town-of-hallstatt-austria-royalty-free-image-1570204697.jpg?crop=0.447xw:1.00xh;0.211xw,0&resize=980:*',
            ),
          ),
        ),
      ),
    );
  }

  static Post get imagePost => const Post.empty().copyWith(
        author: Stubs.postAuthor,
        content: const ImagePostContent(
          text: 'text',
          imageUrl: ImageUrl(
            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/fairytale-town-of-hallstatt-austria-royalty-free-image-1570204697.jpg?crop=0.447xw:1.00xh;0.211xw,0&resize=980:*',
          ),
        ),
        circle: const BasicCircle.empty().copyWith(name: '#Startups', emoji: '🚀'),
        contentStats: const ContentStatsForContent.empty().copyWith(impressions: 44000),
        postedAtString: '2020-01-31',
        createdAtString: '2020-01-31',
      );

  static Post get textPost => const Post.empty().copyWith(
        content: const TextPostContent(
          additionalText:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit egestas justo facilisis turpis nec aliquet. Integer adipiscing molestie id mattis gravida et, quam. ',
          text:
              'Omg that midterm was terrible. Blah blah blah blah... Did anyone else think it was bad or was it just me. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit egestas justo facilisis turpis nec aliquet. Integer adipiscing molestie id mattis gravida et, quam. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit egestas justo facilisis turpis nec aliquet. Integer adipiscing molestie. sdfh kasjlfh asjkl fhkajsl hfkjlas hfklas jhfkajs hfkl ashfklasfh kalsjfh klasjfh kasjlfh aklsjfh klasj hfkalsj fhklasjf hkasj hfkasjlfh kasdjh f',
          color: TextPostColor.blue,
        ),
        author: Stubs.postAuthor,
        postedAtString: '2020-01-31',
        createdAtString: '2020-01-31',
      );

  static PaginatedList<Post> get posts => PaginatedList(
        items: [
          textPost,
          pollPost,
          imagePost,
          linkPost,
        ],
        pageInfo: const PageInfo.empty(),
      );

  static Post get videoPost => const Post.empty().copyWith(
        author: Stubs.postAuthor,
        content: const VideoPostContent.empty(),
        contentStats: const ContentStatsForContent.empty().copyWith(impressions: 0),
        postedAtString: '2020-01-31',
        createdAtString: '2020-01-31',
      );

  static Post get linkPost => const Post.empty().copyWith(
        author: Stubs.postAuthor,
        content: LinkPostContent(
          linkUrl: const LinkUrl('https://www.google.com'),
          metadata: linkMetadata,
        ),
        circle: const BasicCircle.empty().copyWith(name: '#Startups', emoji: '🚀'),
        contentStats: const ContentStatsForContent.empty().copyWith(impressions: 44000),
        postedAtString: '2020-01-31',
        createdAtString: '2020-01-31',
      );

  static LinkMetadata get linkMetadata => const LinkMetadata(
        imageUrl: ImageUrl(
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/fairytale-town-of-hallstatt-austria-royalty-free-image-1570204697.jpg?crop=0.447xw:1.00xh;0.211xw,0&resize=980:*',
        ),
        title: 'Picnic',
        description: 'Dive into communitie',
        host: 'getpicnic.app',
        url: "",
      );

  static Post get pollPost => const Post.empty().copyWith(
        title: 'Poll Post',
        author: Stubs.postAuthor,
        content: const PollPostContent.empty().copyWith(
          votesTotal: 2345,
          question: 'left or right?',
          answers: [
            const PollAnswer(
              id: Id('Left'),
              imageUrl: ImageUrl(
                'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/fairytale-town-of-hallstatt-austria-royalty-free-image-1570204697.jpg?crop=0.447xw:1.00xh;0.211xw,0&resize=980:*',
              ),
              votesCount: 2000,
            ),
            const PollAnswer(
              id: Id('Right'),
              imageUrl: ImageUrl(
                'https://thumbs.dreamstime.com/b/beautiful-golden-autumn-scenery-trees-golden-leaves-sunshine-scotland-united-kingdom-beautiful-golden-autumn-124278811.jpg',
              ),
              votesCount: 345,
            ),
          ],
        ),
        circle: const BasicCircle.empty().copyWith(name: '#Startups', emoji: '🚀'),
        contentStats: const ContentStatsForContent.empty().copyWith(impressions: 44000),
        postedAtString: '2020-01-31',
        createdAtString: '2020-01-31',
      );

  static Sound get sound1 => const Sound(
        id: Id("Sound 1"),
        title: "Sound 1",
        creator: "jon bon jovi",
        icon: ImageUrl("https://picsum.photos/id/417/100"),
        url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
        usesCount: 120 * 20,
        duration: Duration(minutes: 6, seconds: 12),
      );

  static Sound get sound2 => const Sound(
        id: Id("Sound 2"),
        title: "Sound 2",
        creator: "jon bon jovi",
        icon: ImageUrl("https://picsum.photos/id/237/100"),
        url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
        usesCount: 120 * 21,
        duration: Duration(minutes: 6, seconds: 12),
      );

  static ElectionCandidate get electionCandidate => const ElectionCandidate.empty().copyWith(
        votesCount: 1,
        votesPercent: 10.0,
        role: CircleRole.director,
        circleId: const Id('123'),
        publicProfile: const PublicProfile.empty().copyWith(
          user: const User.empty().copyWith(username: '#Daniel', id: const Id('123')),
        ),
      );

  static VoteCandidate get voteCandidate => const VoteCandidate.empty().copyWith(
        votesCount: 1,
        votesPercent: 10.0,
        publicProfile: const PublicProfile.empty().copyWith(
          user: const User.empty().copyWith(username: '#Daniel', id: const Id('123')),
        ),
      );

  static Sound get sound3 => const Sound(
        id: Id("Sound 3"),
        title: "Sound 3",
        creator: "jon bon jovi",
        icon: ImageUrl("https://picsum.photos/id/419/100"),
        url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
        usesCount: 120 * 22,
        duration: Duration(minutes: 6, seconds: 12),
      );

  static TreeComment get pinnedComment => TreeComment(
        id: const Id('pinnedComment'),
        myReaction: LikeDislikeReaction.noReaction,
        isDeleted: false,
        isPinned: true,
        author: user,
        text: 'Yes, this comment is pinned',
        // ignore: no-magic-number
        reactions: <LikeDislikeReaction, int>{
          LikeDislikeReaction.like: 143,
          LikeDislikeReaction.dislike: 0,
        },
        repliesCount: 0,
        parent: const TreeComment.none(),
        postId: Stubs.id,
        createdAtString: "2023-02-08T03:47:52Z",
        children: const PaginatedList.singlePage(),
      );

  static TreeComment get comments => TreeComment.root(
        children: PaginatedList(
          pageInfo: const PageInfo.singlePage(),
          items: [
            TreeComment(
              id: const Id('1'),
              myReaction: LikeDislikeReaction.noReaction,
              isDeleted: false,
              isPinned: false,
              author: const User.empty().copyWith(
                username: 'payamdaliri',
                profileImageUrl: ImageUrl(Assets.images.watermelonWhole.path),
              ),
              text: 'I think this video deserves more likes and appreciation',
              // ignore: no-magic-number
              reactions: <LikeDislikeReaction, int>{
                LikeDislikeReaction.like: 322,
                LikeDislikeReaction.dislike: 1,
              },
              repliesCount: 3,
              parent: const TreeComment.none(),
              postId: Stubs.id,
              createdAtString: "2023-02-07T03:47:52Z",
              children: PaginatedList(
                pageInfo: const PageInfo.singlePage(),
                items: [
                  TreeComment(
                    id: const Id('2'),
                    myReaction: LikeDislikeReaction.noReaction,
                    isDeleted: false,
                    isPinned: false,
                    author: user,
                    text: 'Yes, I do think that too',
                    // ignore: no-magic-number
                    reactions: <LikeDislikeReaction, int>{
                      LikeDislikeReaction.like: 253,
                      LikeDislikeReaction.dislike: 100,
                    },
                    repliesCount: 1,
                    parent: const TreeComment.none(),
                    postId: Stubs.id,
                    createdAtString: "2023-02-07T03:47:52Z",
                    children: PaginatedList(
                      pageInfo: const PageInfo.singlePage(),
                      items: [
                        TreeComment(
                          id: const Id('3'),
                          myReaction: LikeDislikeReaction.like,
                          isDeleted: false,
                          isPinned: false,
                          author: user,
                          text: 'you guys are crazy tbh...',
                          // ignore: no-magic-number
                          reactions: <LikeDislikeReaction, int>{
                            LikeDislikeReaction.like: 2053,
                            LikeDislikeReaction.dislike: 53,
                          },
                          repliesCount: 1,
                          parent: const TreeComment.none(),
                          children: const PaginatedList.singlePage(),
                          postId: Stubs.id,
                          createdAtString: "2023-02-07T03:47:52Z",
                        ),
                        TreeComment(
                          id: const Id('4'),
                          myReaction: LikeDislikeReaction.noReaction,
                          isDeleted: false,
                          isPinned: false,
                          author: user,
                          text: "dumbest thing I've heard 😄",
                          // ignore: no-magic-number
                          reactions: <LikeDislikeReaction, int>{
                            LikeDislikeReaction.like: 51,
                            LikeDislikeReaction.dislike: 0,
                          },
                          repliesCount: 11,
                          parent: const TreeComment.none(),
                          children: const PaginatedList.singlePage(),
                          postId: Stubs.id,
                          createdAtString: "2023-02-07T03:47:52Z",
                        ),
                      ],
                    ),
                  ),
                  TreeComment(
                    id: const Id('5'),
                    myReaction: LikeDislikeReaction.noReaction,
                    isDeleted: false,
                    isPinned: false,
                    author: user,
                    text: "bro you serious?",
                    // ignore: no-magic-number
                    reactions: <LikeDislikeReaction, int>{
                      LikeDislikeReaction.like: 115,
                      LikeDislikeReaction.dislike: 0,
                    },
                    repliesCount: 12,
                    parent: const TreeComment.none(),
                    children: const PaginatedList.singlePage(),
                    postId: Stubs.id,
                    createdAtString: "2023-02-07T03:47:52Z",
                  ),
                  TreeComment(
                    id: const Id('6'),
                    myReaction: LikeDislikeReaction.noReaction,
                    isDeleted: false,
                    isPinned: false,
                    author: user,
                    text: "come on man, it’s awesome!",
                    // ignore: no-magic-number
                    reactions: <LikeDislikeReaction, int>{
                      LikeDislikeReaction.like: 0,
                      LikeDislikeReaction.dislike: 8,
                    },
                    repliesCount: 10,
                    parent: const TreeComment.none(),
                    children: const PaginatedList.singlePage(),
                    postId: Stubs.id,
                    createdAtString: "2023-02-07T03:47:52Z",
                  ),
                ],
              ),
            ),
            TreeComment(
              id: const Id('7'),
              myReaction: LikeDislikeReaction.noReaction,
              isDeleted: false,
              isPinned: false,
              author: user,
              text:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque volutpat viverra sem id pretium. Nam eget est mauris. Fusce sit amet turpis a nisi consectetur tincidunt at vitae diam',
              // ignore: no-magic-number
              reactions: <LikeDislikeReaction, int>{
                LikeDislikeReaction.like: 123,
                LikeDislikeReaction.dislike: 0,
              },
              repliesCount: 1,
              parent: const TreeComment.none(),
              children: const PaginatedList.singlePage(),
              postId: Stubs.id,
              createdAtString: "2023-02-07T03:47:52Z",
            ),
          ],
        ),
      );

  static List<CommentPreview> get commentsPreview => [
        CommentPreview(
          id: const Id('1'),
          myReaction: LikeDislikeReaction.noReaction,
          author: user,
          text: "bro you serious?",
          reactions: <LikeDislikeReaction, int>{
            LikeDislikeReaction.like: 115,
            LikeDislikeReaction.dislike: 0,
          },
          repliesCount: 0,
          postId: Stubs.id,
          createdAtString: "2023-02-07T03:47:52Z",
        ),
        CommentPreview(
          id: const Id('2'),
          myReaction: LikeDislikeReaction.dislike,
          author: user,
          text: "come on man, it’s awesome!",
          reactions: <LikeDislikeReaction, int>{
            LikeDislikeReaction.like: 10,
            LikeDislikeReaction.dislike: 2,
          },
          repliesCount: 0,
          postId: Stubs.id,
          createdAtString: "2023-02-07T03:47:52Z",
        ),
      ];

  static List<CommentPreview> get sixCommentsPreview => [
        ...commentsPreview,
        CommentPreview(
          id: const Id('3'),
          myReaction: LikeDislikeReaction.noReaction,
          author: user,
          text: "saved & shared it 😍",
          reactions: <LikeDislikeReaction, int>{
            LikeDislikeReaction.like: 3,
            LikeDislikeReaction.dislike: 0,
          },
          repliesCount: 0,
          postId: Stubs.id,
          createdAtString: "2023-02-07T03:47:52Z",
        ),
        CommentPreview(
          id: const Id('4'),
          myReaction: LikeDislikeReaction.like,
          author: user,
          text: "awesome",
          reactions: <LikeDislikeReaction, int>{
            LikeDislikeReaction.like: 3,
            LikeDislikeReaction.dislike: 0,
          },
          repliesCount: 0,
          postId: Stubs.id,
          createdAtString: "2023-02-07T03:47:52Z",
        ),
        CommentPreview(
          id: const Id('5'),
          myReaction: LikeDislikeReaction.like,
          author: user,
          text: "perfect",
          reactions: <LikeDislikeReaction, int>{
            LikeDislikeReaction.like: 5,
            LikeDislikeReaction.dislike: 2,
          },
          repliesCount: 0,
          postId: Stubs.id,
          createdAtString: "2023-02-07T03:47:52Z",
        ),
        CommentPreview(
          id: const Id('6'),
          myReaction: LikeDislikeReaction.like,
          author: user,
          text: "keep it up",
          reactions: <LikeDislikeReaction, int>{
            LikeDislikeReaction.like: 3,
            LikeDislikeReaction.dislike: 0,
          },
          repliesCount: 0,
          postId: Stubs.id,
          createdAtString: "2023-02-07T03:47:52Z",
        ),
      ];

  static List<CommentPreview> get tenCommentsPreview => [
        ...sixCommentsPreview,
        CommentPreview(
          id: const Id('7'),
          myReaction: LikeDislikeReaction.noReaction,
          author: user,
          text: "saved & shared it 😍",
          reactions: <LikeDislikeReaction, int>{
            LikeDislikeReaction.like: 3,
            LikeDislikeReaction.dislike: 0,
          },
          repliesCount: 0,
          postId: Stubs.id,
          createdAtString: "2023-02-07T03:47:52Z",
        ),
        CommentPreview(
          id: const Id('8'),
          myReaction: LikeDislikeReaction.like,
          author: user,
          text: "awesome",
          reactions: <LikeDislikeReaction, int>{
            LikeDislikeReaction.like: 3,
            LikeDislikeReaction.dislike: 0,
          },
          repliesCount: 0,
          postId: Stubs.id,
          createdAtString: "2023-02-07T03:47:52Z",
        ),
        CommentPreview(
          id: const Id('9'),
          myReaction: LikeDislikeReaction.like,
          author: user,
          text: "perfect",
          reactions: <LikeDislikeReaction, int>{
            LikeDislikeReaction.like: 3,
            LikeDislikeReaction.dislike: 0,
          },
          repliesCount: 0,
          postId: Stubs.id,
          createdAtString: "2023-02-07T03:47:52Z",
        ),
        CommentPreview(
          id: const Id('10'),
          myReaction: LikeDislikeReaction.like,
          author: user,
          text: "keep it up",
          reactions: <LikeDislikeReaction, int>{
            LikeDislikeReaction.like: 143,
            LikeDislikeReaction.dislike: 0,
          },
          repliesCount: 0,
          postId: Stubs.id,
          createdAtString: "2023-02-07T03:47:52Z",
        ),
      ];

  static PrivacySettings get privacySettings =>
      const PrivacySettings.empty().copyWith(directMessagesFromAccountsYouFollow: true);

  static ChatMessageInput get chatMessageInput => const ChatMessageInput.empty()
      .copyWith(content: 'Im loving Picnic 🍉, there are so many communities', type: ChatMessageType.text);

  static ChatMessage get chatMessageWithAttachment => chatMessage.copyWith(attachments: [attachment]);

  static DisplayableChatMessage get displayableChatMessageWithAttachment => DisplayableChatMessage(
        isFirstInGroup: true,
        isLastInGroup: true,
        chatMessage: chatMessageWithAttachment,
        previousMessage: previousMessage,
      );

  static Attachment get attachment => const Attachment(
        id: Id("attachment1"),
        filename: "image.png",
        url: "https://picsum.photos/id/419/100",
        thumbUrl: "",
        size: 100,
        fileType: "image/png",
        createdAt: "2022-11-28T03:47:52Z",
      );

  static UploadAttachment get uploadAttachmentCorrect => const UploadAttachment(
        filePath: "image.png",
        fileSize: 1024,
        maximumAllowedFileSize: UploadFileSize.chatImageContent,
      );

  static UploadAttachment get uploadAttachmentBigSize => const UploadAttachment(
        filePath: "image.png",
        fileSize: 1024 * 1024 * 1024,
        maximumAllowedFileSize: UploadFileSize.chatImageContent,
      );

  static Language get english => const Language(
        title: 'english',
        code: 'en',
        flag: Constants.englishFlag,
      );

  static List<Language> get languages => [
        english,
        const Language(
          title: 'português',
          code: 'pt',
          flag: Constants.brazilianFlag,
        ),
        const Language(
          title: 'filipino',
          code: 'tl',
          flag: Constants.philippinesFlag,
        ),
        const Language(
          title: 'hindi',
          code: 'hi',
          flag: Constants.indianFlag,
        ),
        const Language(
          title: 'español',
          code: 'es',
          flag: Constants.spanishFlag,
        ),
        const Language(
          title: 'deutsch',
          code: 'de',
          flag: Constants.germanFlag,
        ),
      ];

  static Id get id => const Id.empty();

  static List<ReportReason> get reportReasons => const [
        ReportReason(
          id: Id('1'),
          reason: 'First',
        ),
        ReportReason(
          id: Id('2'),
          reason: 'Second',
        ),
        ReportReason(
          id: Id('3'),
          reason: 'Other',
        ),
      ];

  static List<DeleteAccountReason> get deleteAccountReasons => const [
        DeleteAccountReason(
          title: 'I already have another account',
        ),
        DeleteAccountReason(
          title: 'taking a break',
        ),
      ];

  static TemporaryBannedUser get temporaryBannedUser => TemporaryBannedUser(
        userName: 'helloWorld',
        userId: const Id('0128b6a2-2479-11ed-af58-7fd678b8ddd5'),
        userAvatar: Assets.images.rocket.path,
        unbanTimeStamp: dateTime,
      );

  static TemporaryBannedUser get temporaryBannedUser2 => TemporaryBannedUser(
        userName: 'helloWorld 2',
        userId: const Id('0128b6a2-2479-11ed-af58-7fd678b8ddd6'),
        userAvatar: Assets.images.rocket.path,
        unbanTimeStamp: dateTime,
      );

  static SeedHolder get seedHolder => const SeedHolder.empty().copyWith(owner: Stubs.publicProfile, amountTotal: 500);

  static PermanentBannedUser get permanentBannedUser => PermanentBannedUser(
        userId: Stubs.id,
        userName: Stubs.user.username,
        userAvatar: Stubs.user.profileImageUrl.url,
      );

  static CircleMember get circleMemberDirector => CircleMember(
        user: Stubs.publicProfile2,
        type: CircleRole.director,
        mainRole: const CircleCustomRole.empty(),
      );

  static MessageReport get messageReport => MessageReport(
        reportId: Stubs.id,
        messageId: Stubs.textPost.id,
        moderator: BasicPublicProfile.fromPublicProfile(publicProfile),
        resolvedAt: '2022-11-28T14:43:36.153480893Z',
        spammer: BasicPublicProfile.fromPublicProfile(publicProfile),
        reporter: BasicPublicProfile.fromPublicProfile(publicProfile),
        status: ResolveStatus.resolved,
      );

  static PostReport get postReport => PostReport(
        moderator: BasicPublicProfile.fromPublicProfile(publicProfile),
        post: imagePost,
        reporter: BasicPublicProfile.fromPublicProfile(publicProfile),
        spammer: BasicPublicProfile.fromPublicProfile(publicProfile),
        reportId: Stubs.id,
        status: ResolveStatus.unresolved,
        resolvedAt: '2022-11-28T14:43:36.153480893Z',
      );

  static CommentReport get commentReport => CommentReport(
        moderator: BasicPublicProfile.fromPublicProfile(publicProfile),
        commentId: const Id('commentId'),
        reporter: BasicPublicProfile.fromPublicProfile(publicProfile),
        reportId: Stubs.id,
        status: ResolveStatus.unresolved,
        resolvedAt: '2022-11-28T14:43:36.153480893Z',
        spammer: BasicPublicProfile.fromPublicProfile(publicProfile2),
      );

  static PostRouteResult get postRouteResult => const PostRouteResult.empty();

  static ProfileNotification get profileNotificationFollow => ProfileNotificationFollow(
        id: id,
        userAvatar: Stubs.publicProfile.profileImageUrl.url,
        name: "payamdaliri",
        userId: id,
        iFollow: false,
      );

  static ProfileNotification get profileNotificationGlitterbomb => ProfileNotificationGlitterbomb(
        id: id,
        userAvatar: Stubs.publicProfile.profileImageUrl.url,
        name: "payamdaliri",
        userId: id,
      );

  static Royalty get royalty => Royalty(
        user: Stubs.publicProfile,
        points: 100,
      );

  static ChatMember get chatMember => ChatMember(
        userId: Stubs.id,
        role: ChatRole.moderator,
        user: Stubs.user,
      );

  static ProfileStats get profileStats => const ProfileStats(
        likes: 4200,
        //ignore: no-magic-number
        views: 44000,
        //ignore: no-magic-number
        followers: 152000,
      );

  static PaginatedList<ChatMember> get chatMembers => PaginatedList.singlePage(
        [chatMember],
      );

  static ChatMessagesFeed get chatMessagesFeed => ChatMessagesFeed(
        name: 'Circle name',
        membersCount: 33,
        messages: [Stubs.chatMessage],
        circle: Stubs.circle,
      );

  static GroupWithCircles get groupWithCircles => GroupWithCircles(
        name: 'sports',
        id: const Id('1'),
        circles: [
          const BasicCircle.empty().copyWith(id: const Id('football'), groupId: const Id('1'), name: 'Football'),
          const BasicCircle.empty().copyWith(id: const Id('tennis'), groupId: const Id('1'), name: 'Tennis'),
          const BasicCircle.empty().copyWith(id: const Id('box'), groupId: const Id('1'), name: 'Box'),
          const BasicCircle.empty().copyWith(id: const Id('hockey'), groupId: const Id('1'), name: 'Hockey'),
          const BasicCircle.empty().copyWith(id: const Id('baseball'), groupId: const Id('1'), name: 'Baseball'),
          const BasicCircle.empty().copyWith(id: const Id('handball'), groupId: const Id('1'), name: 'Handball'),
          const BasicCircle.empty().copyWith(id: const Id('basketball'), groupId: const Id('1'), name: 'Basketball'),
        ],
      );

  static GroupWithCircles get groupWithCircles2 => GroupWithCircles(
        name: 'countries & travel',
        id: const Id('2'),
        circles: [
          const BasicCircle.empty().copyWith(id: const Id('ro'), groupId: const Id('2'), name: 'Romania'),
          const BasicCircle.empty().copyWith(id: const Id('it'), groupId: const Id('2'), name: 'Italy'),
          const BasicCircle.empty().copyWith(id: const Id('ar'), groupId: const Id('2'), name: 'Argentina'),
          const BasicCircle.empty().copyWith(id: const Id('usa'), groupId: const Id('2'), name: 'USA'),
          const BasicCircle.empty().copyWith(id: const Id('sp'), groupId: const Id('2'), name: 'Spain'),
          const BasicCircle.empty().copyWith(id: const Id('de'), groupId: const Id('2'), name: 'Germany'),
        ],
      );

  static GroupWithCircles get groupWithCircles3 => GroupWithCircles(
        name: 'dogs',
        id: const Id('3'),
        circles: [
          const BasicCircle.empty().copyWith(id: const Id('pit'), groupId: const Id('3'), name: 'Pitbulls'),
          const BasicCircle.empty()
              .copyWith(id: const Id('gold'), groupId: const Id('3'), name: 'Golden Retrievers lovers'),
          const BasicCircle.empty().copyWith(id: const Id('csd'), groupId: const Id('1'), name: 'cute small dogs'),
        ],
      );

  static GroupWithCircles get groupWithCircles4 => GroupWithCircles(
        name: 'programming & tech',
        id: const Id('4'),
        circles: [
          const BasicCircle.empty()
              .copyWith(id: const Id('flutter'), groupId: const Id('4'), name: 'flutter enthusiasts'),
          const BasicCircle.empty().copyWith(id: const Id('android'), groupId: const Id('4'), name: 'android devs'),
          const BasicCircle.empty().copyWith(id: const Id('ios'), groupId: const Id('4'), name: 'ios maxis'),
        ],
      );

  static ListGroupsInput get listGroupsInput => const ListGroupsInput();

  static MessageActionsOpenEvent get messageActionsOpenEvent => const MessageActionsOpenEvent.empty();

  static BasicChat get singleChat =>
      const BasicChat.empty().copyWith(id: const Id('single'), chatType: ChatType.single);

  static BasicChat get groupChat => const BasicChat.empty().copyWith(chatType: ChatType.group);

  static const String linkUrl = "https://picnic.zone/link";

  static CircleCustomRole get circleCustomRole =>
      const CircleCustomRole.empty().copyWith(name: "temporary mod", emoji: "😁");

  static CircleStats get circleStats => const CircleStats(
        viewsCount: 1,
        postsCount: 1,
        likesCount: 1,
        membersCount: 1,
      );

  static Slice get slice => Slice(
        id: const Id('slice1'),
        name: 'cool slice',
        membersCount: 20,
        description: 'slice description',
        image: const ImageUrl('https://example.com/image.jpg'),
        circleId: Stubs.circle.id,
        ownerId: Stubs.user.id,
        roomsCount: 5,
        iJoined: true,
        iRequestedToJoin: false,
        rules: 'these are some rules, you need to respect them otherwise you might get banned from this slice',
        discoverable: true,
        private: false,
        shareLink: 'https://picnic.zone/slice/slice1',
        pendingJoinRequestsCount: 7,
        sliceRole: SliceRole.member,
      );

  static Slice get sliceDirector => slice.copyWith(role: SliceRole.owner);

  static SliceMember get sliceMemberDirector => SliceMember(
        user: publicProfile,
        role: SliceRole.owner,
        sliceId: Stubs.id,
        userId: Stubs.user.id,
        joinedAtString: '',
        bannedAtString: '',
      );

  static SliceMember get sliceMember => SliceMember(
        user: publicProfile,
        role: SliceRole.member,
        sliceId: Stubs.id,
        userId: Stubs.user.id,
        joinedAtString: '',
        bannedAtString: '',
      );

  static SliceMember get sliceMemberModerator => SliceMember(
        user: publicProfile,
        role: SliceRole.member,
        sliceId: Stubs.id,
        userId: Stubs.user.id,
        joinedAtString: '',
        bannedAtString: '',
      );
  static List<PhoneContact> phoneContacts = [
    PhoneContact.empty().copyWith(
      displayName: 'John Smith',
      phones: [
        const PhoneContactData.empty().copyWith(label: 'home', value: '(555) 555-1234'),
        const PhoneContactData.empty().copyWith(label: 'work', value: '1234567890'),
      ],
    ),
    PhoneContact.empty().copyWith(
      displayName: 'Joan of Arc',
      phones: [
        const PhoneContactData.empty().copyWith(label: 'mobile', value: '(123) 123-1234'),
        const PhoneContactData.empty().copyWith(label: 'work', value: '0987654321'),
      ],
    ),
  ];
  static PaginatedList<UserContact> userContacts = PaginatedList.singlePage(
    [
      const UserContact.empty().copyWith(
        name: 'John Smith',
        contactPhoneNumber: const ContactPhoneNumber(label: 'home', number: '(555) 555-1234'),
      ),
      const UserContact.empty().copyWith(
        name: 'Joan of Arc',
        contactPhoneNumber: const ContactPhoneNumber(label: 'mobile', number: '(123) 123-1234'),
      ),
    ],
  );

  static Governance get election => Governance(
        circleId: const Id.empty(),
        allVotesTotal: 1000,
        myVotesTotal: 200,
        allVotes: [
          const DirectorVote.empty().copyWith(candidate: const VoteCandidate.empty().copyWith(votesCount: 1000))
        ],
        myVotes: [
          const DirectorVote.empty().copyWith(candidate: const VoteCandidate.empty().copyWith(votesCount: 200))
        ],
        mySeedsCount: 200,
      );

  static NotifyType get inviteFriendNotifyType => NotifyType.inviteFriend;

  static AppInfo get appInfo => const AppInfo(
        buildSource: 'firebase',
        buildNumber: '213',
        appVersion: '2.1.0',
        deviceInfo: DeviceSystemInfo(
          platform: DevicePlatform.android,
          device: 'Pixel 4 XL',
          androidSdk: 32,
          osVersion: '12',
        ),
        versionControlInfo: VersionControlInfo(
          branch: 'develop',
          commit: '3478657823456',
        ),
        packageName: 'com.ambertech.amber',
        appName: 'Picnic',
      );

  static Circle get booksCircle => const Circle.empty().copyWith(id: const Id('21'), name: 'books');

  static List<OnboardingCirclesSection> get onBoardingCircles => [
        OnboardingCirclesSection(
          name: 'lifestyle',
          circles: [
            const BasicCircle.empty().copyWith(id: const Id('1'), name: 'teenagers'),
            const BasicCircle.empty().copyWith(id: const Id('2'), name: 'funny'),
            const BasicCircle.empty().copyWith(id: const Id('3'), name: 'memes'),
            const BasicCircle.empty().copyWith(id: const Id('4'), name: 'ama'),
            const BasicCircle.empty().copyWith(id: const Id('5'), name: 'vent'),
            const BasicCircle.empty().copyWith(id: const Id('6'), name: 'fashion'),
            const BasicCircle.empty().copyWith(id: const Id('7'), name: 'makeup'),
            const BasicCircle.empty().copyWith(id: const Id('8'), name: 'applying to college'),
            const BasicCircle.empty().copyWith(id: const Id('9'), name: 'school'),
            const BasicCircle.empty().copyWith(id: const Id('10'), name: 'shifting'),
          ],
        ),
        OnboardingCirclesSection(
          name: 'entertainment',
          circles: [
            const BasicCircle.empty().copyWith(id: const Id('11'), name: 'anime'),
            const BasicCircle.empty().copyWith(id: const Id('12'), name: 'music'),
            const BasicCircle.empty().copyWith(id: const Id('13'), name: 'tlou'),
            const BasicCircle.empty().copyWith(id: const Id('14'), name: 'tv shows'),
            const BasicCircle.empty().copyWith(id: const Id('15'), name: 'roblox'),
            const BasicCircle.empty().copyWith(id: const Id('16'), name: 'gatcha'),
            const BasicCircle.empty().copyWith(id: const Id('17'), name: 'sports'),
            const BasicCircle.empty().copyWith(id: const Id('18'), name: 'kpop'),
            const BasicCircle.empty().copyWith(id: const Id('19'), name: 'kdrama'),
          ],
        ),
        OnboardingCirclesSection(
          name: 'arts',
          circles: [
            const BasicCircle.empty().copyWith(id: const Id('20'), name: 'edits'),
            const BasicCircle.empty().copyWith(id: const Id('21'), name: 'books'),
            const BasicCircle.empty().copyWith(id: const Id('22'), name: 'fandoms'),
            const BasicCircle.empty().copyWith(id: const Id('23'), name: 'writing'),
            const BasicCircle.empty().copyWith(id: const Id('24'), name: 'art'),
            const BasicCircle.empty().copyWith(id: const Id('25'), name: 'diy'),
          ],
        ),
        OnboardingCirclesSection(
          name: 'other',
          circles: [
            const BasicCircle.empty().copyWith(id: const Id('26'), name: 'true crime'),
            const BasicCircle.empty().copyWith(id: const Id('27'), name: 'influencers'),
            const BasicCircle.empty().copyWith(id: const Id('28'), name: 'celebrities'),
            const BasicCircle.empty().copyWith(id: const Id('29'), name: 'storytime'),
            const BasicCircle.empty().copyWith(id: const Id('30'), name: 'pets'),
            const BasicCircle.empty().copyWith(id: const Id('31'), name: 'news'),
          ],
        ),
      ];

  static AuthToken get authToken => const AuthToken(
        accessToken: 'accessToken',
        refreshToken: 'refreshToken',
      );

  static AuthResult get authResult => AuthResult(
        userId: user.id,
        authToken: authToken,
        privateProfile: privateProfile,
      );

  static String get username => 'testUsername';

  static String get recaptchaToken => 'recaptchaToken';

  static String get recaptchaSiteKey => 'recaptchaSiteKey';

  static PaginatedList<Collection> get postCollections => PaginatedList.singlePage(
        [
          const Collection.empty().copyWith(
            id: const Id('1'),
            title: 'collection title',
            previewPosts: List.filled(
              3,
              const Post.empty().copyWith(
                id: const Id('1'),
                title: 'post title',
                content:
                    const ImagePostContent.empty().copyWith(imageUrl: const ImageUrl('https://picsum.photos/200/300')),
              ),
            ),
          ),
          const Collection.empty().copyWith(
            id: const Id('2'),
            title: 'collection title',
            previewPosts: List.filled(
              3,
              const Post.empty().copyWith(
                id: const Id('1'),
                title: 'post title',
                content:
                    const ImagePostContent.empty().copyWith(imageUrl: const ImageUrl('https://picsum.photos/200/300')),
              ),
            ),
          ),
          const Collection.empty().copyWith(
            id: const Id('3'),
            title: 'collection title',
            previewPosts: List.filled(
              3,
              const Post.empty().copyWith(
                id: const Id('1'),
                title: 'post title',
                content:
                    const ImagePostContent.empty().copyWith(imageUrl: const ImageUrl('https://picsum.photos/200/300')),
              ),
            ),
          ),
        ],
      );

  static PostsSortingType get trendingThisWeekPostsSortingType => PostsSortingType.trendingThisWeek;

  static CircleConfig getChatConfig({bool enabled = true}) => CircleConfig(
        type: CircleConfigType.chatting,
        enabled: enabled,
        displayName: "chatting",
        emoji: "💬",
        description: "when disabled, no one has the ability to chat in a circle except for the director",
      );

  static List<CircleConfig> circleConfig = [
    const CircleConfig(
      type: CircleConfigType.chatting,
      enabled: true,
      displayName: "chatting",
      emoji: "💬",
      description: "when disabled, no one has the ability to chat in a circle except for the director",
    ),
    const CircleConfig(
      type: CircleConfigType.comments,
      enabled: true,
      displayName: "comments",
      emoji: "📃",
      description: "when disabled, no one has the ability to post comments on posts except for the director",
    ),
    const CircleConfig(
      type: CircleConfigType.video,
      enabled: true,
      displayName: "video posts",
      emoji: "📼",
      description: "when disabled, no one has the ability to post videos on circle except for the director",
    ),
    const CircleConfig(
      type: CircleConfigType.photo,
      enabled: true,
      displayName: "photo posts",
      emoji: "🏞️",
      description: "when disabled, no one has the ability to post photos on circle except for the director",
    ),
    const CircleConfig(
      type: CircleConfigType.text,
      enabled: true,
      displayName: "thought posts",
      emoji: "💭",
      description: "when disabled, no one has the ability to post thoughts on circle except for the director",
    ),
    const CircleConfig(
      type: CircleConfigType.poll,
      enabled: true,
      displayName: "poll posts",
      emoji: "⚖️",
      description: "when disabled, no one has the ability to post polls on circle except for the director",
    ),
    const CircleConfig(
      type: CircleConfigType.link,
      enabled: true,
      displayName: "link posts",
      emoji: "🔗",
      description: "when disabled, no one has the ability to post links on circle except for the director",
    ),
    const CircleConfig(
      type: CircleConfigType.visibility,
      enabled: true,
      displayName: "visibility",
      emoji: "👀",
      description: "when disabled, no one will be able to see the circle",
    ),
  ];

  static CircleConfig get disabledTextConfig => const CircleConfig(
        type: CircleConfigType.text,
        enabled: false,
        displayName: "thought posts",
        emoji: "💭",
        description: "when disabled, no one has the ability to post thoughts on circle except for the director",
      );

  static Circle get circleWithDisabledTextPosting => Stubs.circle.copyWith(configs: [disabledTextConfig]);

  static Circle get circleWithDisabledChat => Stubs.circle.copyWith(configs: [getChatConfig(enabled: false)]);

  static List<Interest> get onBoardingInterests => [
        const Interest(
          id: Id('id1'),
          name: 'funny',
          emoji: '😀',
        ),
        const Interest(
          id: Id('id2'),
          name: 'gacha',
          emoji: '🥰',
        ),
        const Interest(
          id: Id('id3'),
          name: 'roblox',
          emoji: '🤖',
        ),
        const Interest(
          id: Id('id4'),
          name: 'clowns',
          emoji: '🤡',
        ),
        const Interest(
          id: Id('id5'),
          name: 'shitposting',
          emoji: '💩',
        ),
        const Interest(
          id: Id('id6'),
          name: 'ghosts',
          emoji: '👻',
        ),
        const Interest(
          id: Id('id7'),
          name: 'dark',
          emoji: '💀',
        ),
        const Interest(
          id: Id('id8'),
          name: 'animals',
          emoji: '😼',
        ),
        const Interest(
          id: Id('id9'),
          name: 'aliens',
          emoji: '👽',
        ),
      ];

  static CountryWithDialCode get countryUS => const CountryWithDialCode(
        code: '+1',
        name: 'US',
        flag: '🇺🇸',
      );

  //to disable possibility of creating an instance of this class
  Stubs._();
}
