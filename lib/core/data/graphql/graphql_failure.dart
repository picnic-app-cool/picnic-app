import 'package:collection/collection.dart';
import 'package:graphql/client.dart';
import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class GraphQLFailure implements HasDisplayableFailure {
  const GraphQLFailure.unknown([
    this.cause,
  ]) : type = GraphQLFailureType.unknown;

  const GraphQLFailure.unauthenticated([
    this.cause,
  ]) : type = GraphQLFailureType.unauthenticated;

  const GraphQLFailure.fileSizeTooBig([
    this.cause,
  ]) : type = GraphQLFailureType.fileSizeTooBig;

  const GraphQLFailure.variablePreparationError([
    this.cause,
  ]) : type = GraphQLFailureType.variablePreparationError;

  final GraphQLFailureType type;
  final Object? cause;

  bool get isUnauthenticated => type == GraphQLFailureType.unauthenticated;

  bool get isFileSizeTooBig => type == GraphQLFailureType.fileSizeTooBig;

  List<GraphQLError> get graphQLErrors {
    final error = cause;
    return error is OperationException ? error.graphqlErrors : [];
  }

  String get errorCode {
    final message = graphQLErrors.firstWhereOrNull((it) => it.message.contains('code = '))?.message ?? '';
    try {
      return RegExp(r'code = (.*?)\s').firstMatch(message)?.group(1) ?? '';
    } on Exception {
      return '';
    }
  }

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GraphQLFailureType.unknown:
      case GraphQLFailureType.unauthenticated:
      case GraphQLFailureType.variablePreparationError:
        return DisplayableFailure.commonError();
      case GraphQLFailureType.fileSizeTooBig:
        return DisplayableFailure.commonError(appLocalizations.fileTooBigErrorMessage);
    }
  }

  @override
  String toString() => 'GraphQLFailure{type: $type, cause: $cause}';
}

enum GraphQLFailureType {
  unknown,
  fileSizeTooBig,
  variablePreparationError,
  unauthenticated,
}
