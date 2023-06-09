import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/pods/domain/model/get_recommended_circles_recommendation_kind.dart';

class GetRecommendedCirclesInput extends Equatable {
  const GetRecommendedCirclesInput({
    required this.search,
    required this.cursor,
    required this.kind,
    required this.podId,
  });

  const GetRecommendedCirclesInput.empty()
      : podId = const Id.empty(),
        kind = GetRecommendedCirclesRecommendationKind.launchingPod,
        cursor = const Cursor.empty(),
        search = '';

  final String search;
  final Cursor cursor;
  final GetRecommendedCirclesRecommendationKind kind;
  final Id podId;

  @override
  List<Object> get props => [
        search,
        cursor,
        kind,
        podId,
      ];

  GetRecommendedCirclesInput copyWith({
    String? search,
    Id? podId,
    Cursor? cursor,
    GetRecommendedCirclesRecommendationKind? kind,
  }) {
    return GetRecommendedCirclesInput(
      search: search ?? this.search,
      podId: podId ?? this.podId,
      cursor: cursor ?? this.cursor,
      kind: kind ?? this.kind,
    );
  }
}
