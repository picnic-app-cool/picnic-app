import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_members_failure.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_initial_params.dart';

class SeedRecipientsPresentationModel implements SeedRecipientsViewModel {
  SeedRecipientsPresentationModel.initial(
    SeedRecipientsInitialParams initialParams,
    UserStore userStore,
  )   : recipients = const PaginatedList.empty(),
        recipientsResult = const FutureResult.empty(),
        privateProfile = userStore.privateProfile,
        circleId = initialParams.circleId,
        searchQuery = '';

  SeedRecipientsPresentationModel._({
    required this.recipientsResult,
    required this.recipients,
    required this.circleId,
    required this.privateProfile,
    required this.searchQuery,
  });

  final FutureResult<Either<GetCircleMembersFailure, PaginatedList<PublicProfile>>> recipientsResult;

  @override
  final PaginatedList<PublicProfile> recipients;

  @override
  final PrivateProfile privateProfile;

  @override
  final Id circleId;

  @override
  final String searchQuery;

  @override
  bool get isLoading => recipientsResult.isPending();

  Cursor get cursor => recipients.nextPageCursor();

  SeedRecipientsPresentationModel byAppendingRecepientsList(PaginatedList<PublicProfile> newList) => copyWith(
        recipients: recipients + newList,
      );

  SeedRecipientsPresentationModel byUpdateFollowAction(PublicProfile member) => copyWith(
        recipients: recipients.byUpdatingItem(
          update: (update) => update.copyWith(iFollow: !update.iFollow),
          itemFinder: (finder) => member.id == finder.id,
        ),
      );

  SeedRecipientsPresentationModel copyWith({
    PaginatedList<PublicProfile>? recipients,
    FutureResult<Either<GetCircleMembersFailure, PaginatedList<PublicProfile>>>? recipientsResult,
    Id? circleId,
    String? searchQuery,
    PrivateProfile? privateProfile,
  }) {
    return SeedRecipientsPresentationModel._(
      recipientsResult: recipientsResult ?? this.recipientsResult,
      circleId: circleId ?? this.circleId,
      recipients: recipients ?? this.recipients,
      searchQuery: searchQuery ?? this.searchQuery,
      privateProfile: privateProfile ?? this.privateProfile,
    );
  }
}

abstract class SeedRecipientsViewModel {
  PaginatedList<PublicProfile> get recipients;

  bool get isLoading;

  PrivateProfile get privateProfile;

  Id get circleId;

  String get searchQuery;
}
