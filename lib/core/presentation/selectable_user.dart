import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';

extension SelectableUser on User {
  Selectable<User> toSelectableUser({bool selected = false}) => Selectable(item: this, selected: selected);
}
