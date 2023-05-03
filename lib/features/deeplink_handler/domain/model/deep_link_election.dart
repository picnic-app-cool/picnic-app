import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_type.dart';

class DeepLinkElection extends Equatable implements DeepLink {
  const DeepLinkElection({
    required this.circleId,
  });

  const DeepLinkElection.empty() : circleId = const Id.empty();

  factory DeepLinkElection.fromUri(Uri link) => DeepLinkElection(
        circleId: Id(link.pathSegments[1]),
      );

  final Id circleId;

  @override
  DeepLinkType get type => DeepLinkType.election;

  @override
  bool get requiresAuthenticatedUser => true;

  @override
  List<Object?> get props => [type];

  DeepLinkElection copyWith({
    Id? circleId,
  }) {
    return DeepLinkElection(
      circleId: circleId ?? this.circleId,
    );
  }
}
