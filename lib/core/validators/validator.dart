import 'package:dartz/dartz.dart';

abstract class Validator<INPUT, FAIL> {
  Either<FAIL, Unit> validate(INPUT input);
}

/// General validation error
class ValidationError {
  const ValidationError();
}
