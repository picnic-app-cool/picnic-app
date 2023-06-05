import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/app_tag.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/featured_pods_failure.dart';
import 'package:picnic_app/core/domain/model/generated_token.dart';
import 'package:picnic_app/core/domain/model/get_trending_pods_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_scoped_pod_token_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/domain/model/search_pod_input.dart';
import 'package:picnic_app/core/domain/model/search_pods_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/pods/domain/model/get_pods_tags_failure.dart';
import 'package:picnic_app/features/pods/domain/model/get_saved_pods_failure.dart';
import 'package:picnic_app/features/pods/domain/model/save_pod_failure.dart';

abstract class PodsRepository {
  Future<Either<GetUserScopedPodTokenFailure, GeneratedToken>> getGeneratedAppToken({required Id podId});

  Future<Either<GetTrendingPodsFailure, PaginatedList<PodApp>>> getTrendingPods({Cursor? cursor});

  Future<Either<GetPodsTagsFailure, List<AppTag>>> getPodsTags({required List<Id> podsIdsList});

  Future<Either<SavePodFailure, Unit>> savePod({required Id podId});

  Future<Either<GetSavedPodsFailure, PaginatedList<PodApp>>> getSavedPods({required Cursor nextPageCursor});

  Future<Either<SearchPodsFailure, PaginatedList<PodApp>>> searchPods({required SearchPodInput input});

  Future<Either<FeaturedPodsFailure, PaginatedList<PodApp>>> getFeaturedPods({required Cursor nextPageCursor});
}
