import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/generated_token.dart';
import 'package:picnic_app/core/domain/model/get_trending_pods_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_scoped_pod_token_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

abstract class PodsRepository {
  Future<Either<GetUserScopedPodTokenFailure, GeneratedToken>> getGeneratedAppToken({required Id podId});
  Future<Either<GetTrendingPodsFailure, PaginatedList<PodApp>>> getTrendingPods({Cursor? cursor});
}
