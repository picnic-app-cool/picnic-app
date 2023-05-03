import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/set_language_failure.dart';
import 'package:picnic_app/core/domain/repositories/private_profile_repository.dart';

class SetLanguageUseCase {
  const SetLanguageUseCase(this._privateProfileRepository);

  final PrivateProfileRepository _privateProfileRepository;

  Future<Either<SetLanguageFailure, Unit>> execute({required List<String> languagesCodes}) async {
    return _privateProfileRepository.setLanguage(languagesCodes: languagesCodes);
  }
}
