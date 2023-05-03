import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/top_navigation/feed_items_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/tabs/text_tab_item.dart';

import '../mocks/stubs.dart';
import '../test_utils/test_app_widget.dart';

void main() {
  final forYouFeed = Stubs.feed.copyWith(name: 'For you');
  final gatchaFeed = Stubs.feed.copyWith(name: 'Gatcha');

  testWidgets(
    'should show `show more` after first feed',
    (tester) async {
      final bar = _buildFeedItemsBar(
        tabs: [forYouFeed, gatchaFeed],
      );
      await tester.pumpWidget(bar);
      await tester.pumpAndSettle();
      final forYouButton = _getTabAt(0);
      final seeMoreButton = _getTabAt(1);
      final gatchaButton = _getTabAt(2);
      expect(forYouButton.title, forYouFeed.name);
      expect(seeMoreButton.title, appLocalizations.seeMore);
      expect(gatchaButton.title, gatchaFeed.name);
      expect(find.byType(TextTabItem).evaluate().length, 3);
    },
  );
  testWidgets(
    'should hide `show more` if flag is set to false',
    (tester) async {
      // first feed is supposed to be `for you`, and we want the `see more` to be shown immediately after.
      // as of until March 22, 2023 there is no way of recognizing which feed is the special `for you` one unfortunately
      // hence we need to base on the position and add `see more` always at index 1
      final bar = _buildFeedItemsBar(
        tabs: [forYouFeed, gatchaFeed],
        showSeeMoreButton: false,
      );
      await tester.pumpWidget(bar);
      await tester.pumpAndSettle();
      final forYouButton = _getTabAt(0);
      final gatchaButton = _getTabAt(1);
      expect(forYouButton.title, forYouFeed.name);
      expect(gatchaButton.title, gatchaFeed.name);
      expect(find.byType(TextTabItem).evaluate().length, 2);
    },
  );

  testWidgets(
    'should show `show more` even if list is empty',
    (tester) async {
      final bar = _buildFeedItemsBar(
        tabs: [],
      );
      await tester.pumpWidget(bar);
      await tester.pumpAndSettle();
      final seeMoreButton = _getTabAt(0);
      expect(seeMoreButton.title, appLocalizations.seeMore);
      expect(find.byType(TextTabItem).evaluate().length, 1);
    },
  );
}

TestAppWidget _buildFeedItemsBar({
  required List<Feed> tabs,
  bool showSeeMoreButton = true,
}) {
  return TestAppWidget(
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: FeedItemsBar(
        tabs: tabs,
        onTabChanged: (_) => doNothing(),
        selectedFeed: Stubs.feed,
        showSeeMoreButton: showSeeMoreButton,
      ),
    ),
  );
}

TextTabItem _getTabAt(int index) {
  final evaluatedList = find.byType(TextTabItem).at(index).evaluate();
  return evaluatedList.first.widget as TextTabItem;
}
