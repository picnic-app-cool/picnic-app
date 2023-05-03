import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

class GqlSuccessPayload {
  GqlSuccessPayload({
    required this.success,
  });

  factory GqlSuccessPayload.fromJson(
    Map<String, dynamic>? json,
  ) {
    return GqlSuccessPayload(
      success: asT<bool>(json, 'success'),
    );
  }

  final bool success;
}

extension GqlSuccessPayloadMapSuccess<T> on Future<Either<T, GqlSuccessPayload>> {
  Future<Either<T, Unit>> mapSuccessPayload({required T onFailureReturn}) =>
      catchSuccess((result) => result.success ? success(result) : failure(onFailureReturn)) //
          .mapSuccess((response) => unit);
}
