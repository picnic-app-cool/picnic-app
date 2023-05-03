import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/chat_messages_feed.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ReportedMessagePresentationModel implements ReportedMessageViewModel {
  /// Creates the initial state
  ReportedMessagePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    ReportedMessageInitialParams initialParams,
  )   : circleId = initialParams.circleId,
        reportId = initialParams.reportId,
        reportedMessageId = initialParams.reportedMessageId,
        chatMessagesFeed = initialParams.chatMessagesFeed,
        reportedMessageAuthor = initialParams.reportedMessageAuthor;

  /// Used for the copyWith method
  ReportedMessagePresentationModel._({
    required this.circleId,
    required this.reportedMessageId,
    required this.chatMessagesFeed,
    required this.reportedMessageAuthor,
    required this.reportId,
  });

  final Id circleId;
  final Id reportId;

  @override
  final Id reportedMessageId;

  @override
  final ChatMessagesFeed chatMessagesFeed;

  @override
  final BasicPublicProfile reportedMessageAuthor;

  ReportedMessagePresentationModel copyWith({
    Id? circleId,
    Id? reportedMessageId,
    ChatMessagesFeed? chatMessagesFeed,
    BasicPublicProfile? reportedMessageAuthor,
    Id? reportId,
  }) {
    return ReportedMessagePresentationModel._(
      circleId: circleId ?? this.circleId,
      reportedMessageId: reportedMessageId ?? this.reportedMessageId,
      chatMessagesFeed: chatMessagesFeed ?? this.chatMessagesFeed,
      reportedMessageAuthor: reportedMessageAuthor ?? this.reportedMessageAuthor,
      reportId: reportId ?? this.reportId,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ReportedMessageViewModel {
  BasicPublicProfile get reportedMessageAuthor;

  ChatMessagesFeed get chatMessagesFeed;

  Id get reportedMessageId;
}
