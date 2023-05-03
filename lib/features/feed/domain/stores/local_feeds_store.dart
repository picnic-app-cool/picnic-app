import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';

class LocalFeedsStore extends Cubit<List<Feed>> {
  LocalFeedsStore({List<Feed>? feeds}) : super(feeds ?? []);

  @override
  Stream<UnmodifiableListView<Feed>> get stream => super.stream.map((e) => UnmodifiableListView(e));

  UnmodifiableListView<Feed> get feeds => UnmodifiableListView(state);

  void add(Feed feed) => tryEmit([...feeds, feed]);
}
