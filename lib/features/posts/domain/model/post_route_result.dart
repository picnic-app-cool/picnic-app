import 'package:equatable/equatable.dart';

class PostRouteResult extends Equatable {
  const PostRouteResult({
    this.postReported = false,
    this.userBanned = false,
    this.postRemoved = false,
  });

  const PostRouteResult.empty()
      : postReported = false,
        postRemoved = false,
        userBanned = false;

  final bool postReported;
  final bool userBanned;
  final bool postRemoved;

  bool get anyActionTaken => postReported || userBanned || postRemoved;

  @override
  List<Object?> get props => [
        postReported,
        userBanned,
        postRemoved,
      ];

  PostRouteResult copyWith({
    bool? postReported,
    bool? userBanned,
    bool? postRemoved,
  }) =>
      PostRouteResult(
        postReported: postReported ?? this.postReported,
        userBanned: userBanned ?? this.userBanned,
        postRemoved: postRemoved ?? this.postRemoved,
      );
}
