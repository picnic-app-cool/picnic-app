import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/utils/utils.dart';

class CollectionInitialParams {
  const CollectionInitialParams({
    required this.collection,
    this.onPostRemovedCallback,
  });

  final Collection collection;
  final VoidCallback? onPostRemovedCallback;
}
