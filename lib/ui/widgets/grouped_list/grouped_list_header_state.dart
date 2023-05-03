import 'package:equatable/equatable.dart';

class GroupedListHeaderState extends Equatable {
  const GroupedListHeaderState({
    required this.initialScrollPosition,
    required this.scrollPosition,
    required this.scrollOffset,
    required this.overlappedItem,
    required this.overlappedGroupItem,
    required this.respectScrollOffset,
    required this.isVisible,
    required this.isOutOfBounds,
  });

  const GroupedListHeaderState.empty()
      : initialScrollPosition = 0,
        scrollPosition = 0,
        scrollOffset = 0,
        overlappedItem = 0,
        overlappedGroupItem = -1,
        respectScrollOffset = false,
        isVisible = false,
        isOutOfBounds = true;

  final double initialScrollPosition;
  final double scrollPosition;
  final double scrollOffset;
  final int overlappedItem;
  final int overlappedGroupItem;
  final bool respectScrollOffset;
  final bool isVisible;
  final bool isOutOfBounds;

  double get offset {
    final scrollDiff = (initialScrollPosition - scrollPosition).abs();
    return respectScrollOffset ? -(scrollOffset.abs() - scrollDiff) : -scrollDiff;
  }

  @override
  List<Object?> get props => [
        initialScrollPosition,
        scrollPosition,
        scrollOffset,
        overlappedItem,
        overlappedGroupItem,
        respectScrollOffset,
        isVisible,
        isOutOfBounds,
      ];

  GroupedListHeaderState copyWith({
    double? initialScrollPosition,
    double? scrollPosition,
    double? scrollOffset,
    int? overlappedItem,
    int? overlappedGroupItem,
    bool? respectScrollOffset,
    bool? isVisible,
    bool? isOutOfBounds,
  }) {
    return GroupedListHeaderState(
      initialScrollPosition: initialScrollPosition ?? this.initialScrollPosition,
      scrollPosition: scrollPosition ?? this.scrollPosition,
      scrollOffset: scrollOffset ?? this.scrollOffset,
      overlappedItem: overlappedItem ?? this.overlappedItem,
      overlappedGroupItem: overlappedGroupItem ?? this.overlappedGroupItem,
      respectScrollOffset: respectScrollOffset ?? this.respectScrollOffset,
      isVisible: isVisible ?? this.isVisible,
      isOutOfBounds: isOutOfBounds ?? this.isOutOfBounds,
    );
  }
}
