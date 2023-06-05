import 'package:picnic_app/core/domain/model/app_tag.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/pods/pods_categories_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PodsCategoriesPresentationModel implements PodsCategoriesViewModel {
  /// Creates the initial state
  PodsCategoriesPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PodsCategoriesInitialParams initialParams,
  )   : tagsList = [],
        podsList = const PaginatedList.empty();

  /// Used for the copyWith method
  PodsCategoriesPresentationModel._({
    required this.tagsList,
    required this.podsList,
  });

  @override
  final List<Selectable<AppTag>> tagsList;

  @override
  final PaginatedList<PodApp> podsList;

  Cursor get cursor => podsList.nextPageCursor();

  List<Selectable<AppTag>> byTogglingTag(AppTag tag) => tagsList.map(
        (it) {
          return it.item.id == tag.id ? it.copyWith(selected: !it.selected) : it;
        },
      ).toList();

  List<Id> getSelectedTagsIds() => tagsList.where((tag) => tag.selected).map((tag) => tag.item.id).toList();

  PodsCategoriesPresentationModel copyWith({
    List<Selectable<AppTag>>? tagsList,
    PaginatedList<PodApp>? podsList,
  }) {
    return PodsCategoriesPresentationModel._(
      tagsList: tagsList ?? this.tagsList,
      podsList: podsList ?? this.podsList,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class PodsCategoriesViewModel {
  List<Selectable<AppTag>> get tagsList;

  PaginatedList<PodApp> get podsList;
}
