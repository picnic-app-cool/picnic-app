import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/feed/domain/model/feed_type.dart';

class Feed extends Equatable {
  const Feed({
    required this.id,
    required this.feedType,
    required this.name,
    required this.circleId,
    required this.membersCount,
    required this.emoji,
    required this.imageFile,
  });

  const Feed.empty()
      : id = const Id.empty(),
        feedType = FeedType.custom,
        name = '',
        circleId = const Id.empty(),
        membersCount = -1,
        emoji = '',
        imageFile = '';

  final Id id;

  final FeedType feedType;

  ///title of the feed, probably circle's name, but can also be 'Popular' for example"
  final String name;

  ///optional id of the circle this feed belongs to
  final Id circleId;

  /// optional members count of the circle this feed belongs to
  final int membersCount;

  /// optional emoji of the circle this feed belongs to
  final String emoji;

  /// optional image of the circle this feed belongs to
  final String imageFile;

  @override
  List<Object?> get props => [
        id,
        feedType,
        name,
        circleId,
        membersCount,
        emoji,
        imageFile,
      ];

  Feed copyWith({
    Id? id,
    FeedType? feedType,
    String? name,
    Id? circleId,
    int? membersCount,
    String? emoji,
    String? imageFile,
  }) {
    return Feed(
      id: id ?? this.id,
      feedType: feedType ?? this.feedType,
      name: name ?? this.name,
      circleId: circleId ?? this.circleId,
      membersCount: membersCount ?? this.membersCount,
      emoji: emoji ?? this.emoji,
      imageFile: imageFile ?? this.imageFile,
    );
  }
}

extension FeedListExtension on List<Feed> {
  bool hasTheSameIdsAs(List<Feed> list) {
    final oldIdsList = map((e) => e.id).toList();
    final newIdsList = list.map((e) => e.id).toList();

    newIdsList.sort((a, b) => a.value.compareTo(b.value));
    oldIdsList.sort((a, b) => a.value.compareTo(b.value));

    return newIdsList != oldIdsList;
  }
}
