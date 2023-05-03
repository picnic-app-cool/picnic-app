import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/get_language_failure.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/features/main/domain/repositories/language_repository.dart';

class GetLanguagesListUseCase {
  const GetLanguagesListUseCase(
    this._languageRepository,
  );

  final LanguageRepository _languageRepository;

  Future<Either<GetLanguageFailure, List<Language>>> execute() => _languageRepository.getLanguages();
}
