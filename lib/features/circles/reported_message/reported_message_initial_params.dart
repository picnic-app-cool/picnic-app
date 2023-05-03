import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/chat_messages_feed.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class ReportedMessageInitialParams {
  const ReportedMessageInitialParams({
    this.circleId = const Id.empty(),
    this.reportId = const Id.empty(),
    this.reportedMessageId = const Id.empty(),
    this.reportedMessageAuthor = const BasicPublicProfile.empty(),
    this.chatMessagesFeed = const ChatMessagesFeed.empty(),
  });

  final Id circleId;
  final Id reportId;
  final Id reportedMessageId;
  final BasicPublicProfile reportedMessageAuthor;
  final ChatMessagesFeed chatMessagesFeed;
}
