import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';

class UserCirclesStore extends Cubit<PaginatedList<BasicCircle>> {
  UserCirclesStore({PaginatedList<BasicCircle>? userCircles}) : super(userCircles ?? const PaginatedList.singlePage());

  PaginatedList<BasicCircle> get userCircles => state;

  set userCircles(PaginatedList<BasicCircle> userCircles) {
    tryEmit(userCircles);
  }

  void addCircle(BasicCircle circle) {
    final updatedCircles = userCircles.byAppending(PaginatedList.singlePage([circle]));
    tryEmit(updatedCircles);
  }

  void removeCircle(BasicCircle circle) {
    final updatedCircles = userCircles;
    final temp = updatedCircles.byRemovingWhere((element) => element.id == circle.id);
    tryEmit(temp);
  }
}
