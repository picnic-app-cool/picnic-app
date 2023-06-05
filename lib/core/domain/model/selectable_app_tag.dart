import 'package:picnic_app/core/domain/model/app_tag.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';

extension SelectableAppTag on AppTag {
  Selectable<AppTag> toSelectableTag({bool selected = false}) => Selectable(item: this, selected: selected);
}
