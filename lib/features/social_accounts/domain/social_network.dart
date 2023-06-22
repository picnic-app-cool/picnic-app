import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/social_accounts/domain/social_network_type.dart';

class SocialNetwork extends Equatable {
  const SocialNetwork({
    required this.type,
    required this.assetImagePath,
  });

  const SocialNetwork.empty()
      : assetImagePath = '',
        type = SocialNetworkType.unknown;

  final String assetImagePath;
  final SocialNetworkType type;

  @override
  List<Object> get props => [
        assetImagePath,
        type,
      ];

  SocialNetwork copyWith({
    String? assetImagePath,
    SocialNetworkType? type,
  }) {
    return SocialNetwork(
      assetImagePath: assetImagePath ?? this.assetImagePath,
      type: type ?? this.type,
    );
  }
}
