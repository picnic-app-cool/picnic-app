import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/search_users_failure.dart';
import 'package:picnic_app/core/domain/use_cases/search_users_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_navigator.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_presentation_model.dart';

class SeedRecipientsPresenter extends Cubit<SeedRecipientsViewModel> {
  SeedRecipientsPresenter(
    super.model,
    this.navigator,
    this._debouncer,
    this._searchUsersUseCase,
  );

  final SeedRecipientsNavigator navigator;
  final SearchUsersUseCase _searchUsersUseCase;

  final Debouncer _debouncer;

  // ignore: unused_element
  SeedRecipientsPresentationModel get _model => state as SeedRecipientsPresentationModel;

  void onTapClose() => navigator.closeWithResult(null);

  void onUserSearch(String value) {
    if (value != _model.searchQuery) {
      _debouncer.debounce(
        const LongDuration(),
        () {
          tryEmit(_model.copyWith(searchQuery: value));
          loadMoreCircleMembers(fromScratch: true);
        },
      );
    }
  }

  void onTapSelectRecipient(PublicProfile publicProfile) => navigator.closeWithResult(publicProfile);

  Future<Either<SearchUsersFailure, PaginatedList<PublicProfile>>> loadMoreCircleMembers({bool fromScratch = false}) =>
      _searchUsersUseCase
          .execute(
            query: _model.searchQuery,
            nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.cursor,
            ignoreMyself: true,
          )
          .doOn(
            success: (recipients) => tryEmit(
              fromScratch
                  ? _model.copyWith(recipients: recipients)
                  : _model.byAppendingRecepientsList(
                      recipients,
                    ),
            ),
          );
}
