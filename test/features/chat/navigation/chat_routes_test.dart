// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_navigator.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_page.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_navigator.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_page.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_navigator.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mock_definitions.dart';

void main() {
  late TestChatNavigator navigator;

  test("circle chat details should always open with `useRoot` option", () {
    navigator.openCircleChat(MockCircleChatInitialParams(), pushAsReplacement: true);
    verify(() => Mocks.appNavigator.pushReplacement<void>(any(), useRoot: true));
    navigator.openCircleChat(MockCircleChatInitialParams(), pushAsReplacement: false);
    verify(() => Mocks.appNavigator.push<void>(any(), useRoot: true));
  });

  test("group chat details should always open with `useRoot` option", () {
    navigator.openGroupChat(MockGroupChatInitialParams(), pushAsReplacement: true);
    verify(() => Mocks.appNavigator.pushReplacement<void>(any(), useRoot: true));
    navigator.openGroupChat(MockGroupChatInitialParams(), pushAsReplacement: false);
    verify(() => Mocks.appNavigator.push<void>(any(), useRoot: true));
  });

  test("group chat details should always open with `useRoot` option", () {
    navigator.openSingleChat(MockSingleChatInitialParams(), pushAsReplacement: true);
    verify(() => navigator.appNavigator.pushReplacement<void>(any(), useRoot: true));
    navigator.openSingleChat(MockSingleChatInitialParams(), pushAsReplacement: false);
    verify(() => navigator.appNavigator.push<void>(any(), useRoot: true));
  });

  setUp(() {
    navigator = TestChatNavigator();
    reRegister(GroupChatPage(presenter: MockGroupChatPresenter()));
    reRegister(SingleChatPage(presenter: MockSingleChatPresenter()));
    reRegister(CircleChatPage(presenter: MockCircleChatPresenter()));
    when(
      () => Mocks.appNavigator.push<void>(
        any(),
        useRoot: any(named: 'useRoot'),
        context: any(named: 'context'),
      ),
    ).thenAnswer((_) => Future.value());
    when(
      () => Mocks.appNavigator.pushReplacement<void>(
        any(),
        useRoot: any(named: 'useRoot'),
        context: any(named: 'context'),
      ),
    ).thenAnswer((_) => Future.value());
  });
}

class TestChatNavigator with CircleChatRoute, SingleChatRoute, GroupChatRoute {
  @override
  AppNavigator get appNavigator => Mocks.appNavigator;
}
