import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_type.dart';

class DeepLinkGeneral extends Equatable implements DeepLink {
  const DeepLinkGeneral();

  const DeepLinkGeneral.empty();

  @override
  DeepLinkType get type => DeepLinkType.general;

  @override
  bool get requiresAuthenticatedUser => false;

  @override
  List<Object?> get props => [];
}
