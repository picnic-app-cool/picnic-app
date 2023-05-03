import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/get_should_show_circles_selection_failure.dart';
import 'package:picnic_app/core/domain/repositories/user_preferences_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

class GetShouldShowCirclesSelectionUseCase {
  const GetShouldShowCirclesSelectionUseCase(this._userPreferencesRepository);

  final UserPreferencesRepository _userPreferencesRepository;

  Future<Either<GetShouldShowCirclesSelectionFailure, bool>> execute() async {
    return _userPreferencesRepository
        .shouldShowCirclesSelection()
        .mapFailure(GetShouldShowCirclesSelectionFailure.unknown);
  }
}
