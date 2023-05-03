import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_type.dart';

//ignore: missing_empty_constructor, missing_copy_with_method
class DeepLinkUserSeeds extends Equatable implements DeepLink {
  const DeepLinkUserSeeds();

  @override
  DeepLinkType get type => DeepLinkType.userSeeds;

  @override
  bool get requiresAuthenticatedUser => true;

  @override
  List<Object?> get props => [type];
}
