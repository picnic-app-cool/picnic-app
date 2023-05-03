import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/get_language_failure.dart';
import 'package:picnic_app/core/domain/model/language.dart';

abstract class LanguageRepository {
  Future<Either<GetLanguageFailure, List<Language>>> getLanguages();
}
