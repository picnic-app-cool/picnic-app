import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_type.dart';

class DeepLinkCircle extends Equatable implements DeepLink {
  const DeepLinkCircle({
    required this.circleId,
    required this.circleName,
  });

  const DeepLinkCircle.empty()
      : circleId = const Id.empty(),
        circleName = '';

  factory DeepLinkCircle.fromUriId(Uri link) => DeepLinkCircle(
        circleId: Id(link.pathSegments[1]),
        circleName: '',
      );

  factory DeepLinkCircle.fromUriCircleName(Uri link) => DeepLinkCircle(
        circleId: const Id.empty(),
        circleName: link.pathSegments[1],
      );

  final Id circleId;
  final String circleName;

  @override
  DeepLinkType get type => DeepLinkType.circle;

  @override
  bool get requiresAuthenticatedUser => true;

  @override
  List<Object?> get props => [
        circleId,
        circleName,
        type,
      ];

  DeepLinkCircle copyWith({
    Id? circleId,
    String? circleName,
  }) {
    return DeepLinkCircle(
      circleId: circleId ?? this.circleId,
      circleName: circleName ?? this.circleName,
    );
  }
}
