//ignore_for_file: constant_identifier_names, too_many_public_members

import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';

class GetRecommendedChatsInput extends Equatable {
  const GetRecommendedChatsInput({
    required this.kind,
    required this.search,
    required this.context,
    required this.cursor,
  });

  const GetRecommendedChatsInput.empty()
      : kind = ChatRecommendationKind.SharingPost,
        search = '',
        context = const GetRecommendedChatsContext.empty(),
        cursor = const Cursor.empty();

  final ChatRecommendationKind kind;
  final String search;
  final GetRecommendedChatsContext context;
  final Cursor cursor;

  @override
  List<Object?> get props => [
        kind,
        search,
        context,
        cursor,
      ];

  GetRecommendedChatsInput copyWith({
    ChatRecommendationKind? kind,
    String? search,
    GetRecommendedChatsContext? context,
    Cursor? cursor,
  }) {
    return GetRecommendedChatsInput(
      kind: kind ?? this.kind,
      search: search ?? this.search,
      context: context ?? this.context,
      cursor: cursor ?? this.cursor,
    );
  }
}

class GetRecommendedChatsContext extends Equatable {
  const GetRecommendedChatsContext({
    required this.appId,
    required this.postId,
    required this.userId,
    required this.circleId,
  });

  const GetRecommendedChatsContext.empty()
      : appId = '',
        postId = '',
        userId = '',
        circleId = '';

  final String appId;
  final String postId;
  final String userId;
  final String circleId;

  @override
  List<Object?> get props => [
        appId,
        postId,
        userId,
        circleId,
      ];

  GetRecommendedChatsContext copyWith({
    String? appId,
    String? postId,
    String? userId,
    String? circleId,
  }) {
    return GetRecommendedChatsContext(
      appId: appId ?? this.appId,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      circleId: circleId ?? this.circleId,
    );
  }
}

enum ChatRecommendationKind {
  SharingPost,
  SharingApp,
  SharingUser,
  SharingCircle,
}
