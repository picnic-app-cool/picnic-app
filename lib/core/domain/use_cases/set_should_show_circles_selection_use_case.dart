import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/set_should_show_circles_selection_failure.dart';
import 'package:picnic_app/core/domain/repositories/user_preferences_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

class SetShouldShowCirclesSelectionUseCase {
  const SetShouldShowCirclesSelectionUseCase(this._userPreferencesRepository);

  final UserPreferencesRepository _userPreferencesRepository;

  Future<Either<SetShouldShowCirclesSelectionFailure, bool>> execute({required bool shouldShow}) async {
    return _userPreferencesRepository
        .saveShouldShowCirclesSelection(shouldShow: shouldShow)
        .mapFailure(SetShouldShowCirclesSelectionFailure.unknown);
  }
}
