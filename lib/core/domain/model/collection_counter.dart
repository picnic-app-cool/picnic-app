import 'package:equatable/equatable.dart';

class CollectionCounter extends Equatable {
  const CollectionCounter({
    required this.posts,
  });

  const CollectionCounter.empty() : posts = 0;

  final int posts;

  @override
  List<Object?> get props => [
        posts,
      ];

  CollectionCounter copyWith({
    int? posts,
  }) {
    return CollectionCounter(
      posts: posts ?? this.posts,
    );
  }
}
