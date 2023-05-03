import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/ui/widgets/paging_list/load_more_scroll_notification.dart';

void main() {
  group(
    'Load more scroll notification widget test',
    () {
      testWidgets(
        'Successful execution of loadMore method',
        (widgetTester) async {
          final loadMoreTester = LoadMoreTester(numberOfPages: 5);
          await widgetTester.pumpWidget(
            _LoadMoreScrollNotificationTest(
              loadMoreTester: loadMoreTester,
            ),
          );
          await widgetTester.pumpAndSettle();
          expect(loadMoreTester.loadMoreCount, 1);
          expect(loadMoreTester.isLoading, true);
          expect(loadMoreTester.items.length, 0);
          loadMoreTester.flushPageLoading();
          await widgetTester.pumpAndSettle();
          expect(loadMoreTester.items.length, LoadMoreTester.pageSize);

          final notVisibleItemFinder = find.byKey(const ValueKey(0));
          final itemFinder = find.byKey(const ValueKey(19));
          await widgetTester.scrollUntilVisible(
            itemFinder,
            300,
            maxScrolls: 1000,
          );
          await widgetTester.pumpAndSettle();
          expect(loadMoreTester.loadMoreCount, 2);
          expect(notVisibleItemFinder, findsNothing);
          expect(itemFinder, findsOneWidget);
        },
      );

      testWidgets(
        'Widget with empty pages',
        (widgetTester) async {
          final loadMoreTester = LoadMoreTester(numberOfPages: 0);
          await widgetTester.pumpWidget(
            _LoadMoreScrollNotificationTest(
              loadMoreTester: loadMoreTester,
            ),
          );
          await widgetTester.pumpAndSettle();
          expect(loadMoreTester.loadMoreCount, 0);
          expect(loadMoreTester.isLoading, false);
          expect(loadMoreTester.items.length, 0);

          loadMoreTester.flushPageLoading();
          await widgetTester.pumpAndSettle();
          expect(loadMoreTester.loadMoreCount, 0);
          expect(loadMoreTester.items.length, 0);
        },
      );
    },
  );
}

class _LoadMoreScrollNotificationTest extends StatelessWidget {
  const _LoadMoreScrollNotificationTest({
    required this.loadMoreTester,
  });

  final LoadMoreTester loadMoreTester;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoadMoreScrollNotification(
          emptyItems: loadMoreTester.items.isEmpty,
          hasMore: loadMoreTester.hasMore,
          loadMore: loadMoreTester.loadMore,
          builder: (context) => ListView.builder(
            physics: const PageScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: loadMoreTester.items.length,
            itemBuilder: (context, index) {
              final item = loadMoreTester.items[index];
              return SizedBox(
                key: ValueKey(item),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Text(
                    '$item',
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class LoadMoreTester {
  LoadMoreTester({required int numberOfPages}) : _numberOfPages = numberOfPages;

  static const pageSize = 20;
  final int _numberOfPages;
  final List<int> _items = [];

  int _loadMoreCount = 0;

  int get loadMoreCount => _loadMoreCount;

  Completer<void>? _loadMoreCompleter;

  List<int> get items => List.unmodifiable(_items);

  bool get hasMore => _loadMoreCount < _numberOfPages - 1;

  bool get isLoading => _loadMoreCompleter?.isCompleted == false;

  void flushPageLoading() {
    _loadMoreCompleter?.complete();
    _loadMoreCompleter = null;
  }

  Future<void> loadMore() async {
    if (_loadMoreCompleter != null && !_loadMoreCompleter!.isCompleted) {
      throw "Requesting new page before loading previous finished";
    }
    _loadMoreCount++;
    _loadMoreCompleter = Completer();
    return _loadMoreCompleter!.future.then((value) => _insertPage());
  }

  void _insertPage() {
    _items.addAll(List.generate(pageSize, (index) => _items.length + index));
  }
}
