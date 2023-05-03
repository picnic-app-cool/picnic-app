import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';

extension SelectablePublicProfile on PublicProfile {
  Selectable<PublicProfile> toSelectable({bool selected = false}) => Selectable(item: this, selected: selected);
}
