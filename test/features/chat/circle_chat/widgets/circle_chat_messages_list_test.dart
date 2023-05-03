import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/chat/circle_chat/widgets/circle_chat_messages_list.dart';
import 'package:picnic_app/features/chat/circle_chat/widgets/user_banned_indicator.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_actions.dart';

import '../../../../test_extensions/widget_tester_extensions.dart';

void main() {
  group('CircleChatMessagesList', () {
    CircleChatMessagesList getCircleChatMessagesList({required bool isUserBanned}) {
      return CircleChatMessagesList(
        messages: const PaginatedList.empty(),
        loadMore: () async {},
        onTapFriendAvatar: (_) {},
        onTapOwnAvatar: () {},
        chatMessageContentActions: ChatMessageContentActions.empty(),
        dragOffset: 0,
        now: CurrentTimeProvider().currentTime,
        isUserBanned: isUserBanned,
      );
    }

    testWidgets('shows UserBannedIndicator when user is banned', (tester) async {
      final circleChatMessagesList = getCircleChatMessagesList(isUserBanned: true);
      await tester.setupWidget(circleChatMessagesList);

      final userBannedIndicator = find.byType(UserBannedIndicator);

      expect(userBannedIndicator, findsOneWidget);
    });

    testWidgets('hides UserBannedIndicator when user is NOT banned', (tester) async {
      final circleChatMessagesList = getCircleChatMessagesList(isUserBanned: false);
      await tester.setupWidget(circleChatMessagesList);

      final userBannedIndicator = find.byType(UserBannedIndicator);

      expect(userBannedIndicator, findsNothing);
    });
  });
}
