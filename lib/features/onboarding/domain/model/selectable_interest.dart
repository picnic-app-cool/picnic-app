import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/features/onboarding/domain/model/interest.dart';

extension SelectableInterest on Interest {
  Selectable<Interest> toSelectableInterest({bool selected = false}) => Selectable(item: this, selected: selected);
}
