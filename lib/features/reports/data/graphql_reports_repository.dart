import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/model/gql_success_payload.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/reports/data/model/gql_create_report_input_json.dart';
import 'package:picnic_app/features/reports/data/model/gql_report_input_json.dart';
import 'package:picnic_app/features/reports/data/model/gql_report_reasons_list_json.dart';
import 'package:picnic_app/features/reports/data/reports_queries.dart';
import 'package:picnic_app/features/reports/domain/model/create_circle_report_failure.dart';
import 'package:picnic_app/features/reports/domain/model/create_global_report_failure.dart';
import 'package:picnic_app/features/reports/domain/model/create_report_input.dart';
import 'package:picnic_app/features/reports/domain/model/get_report_reasons_failure.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/domain/model/report_input.dart';
import 'package:picnic_app/features/reports/domain/model/report_reason.dart';
import 'package:picnic_app/features/reports/domain/repositories/reports_repository.dart';
import 'package:picnic_app/utils/extensions/future_retarder.dart';

class GraphqlReportsRepository with FutureRetarder implements ReportsRepository {
  GraphqlReportsRepository(
    this._gqlClient,
  );

  final GraphQLClient _gqlClient;

  @override
  Future<Either<GetReportReasonsFailure, List<ReportReason>>> getGlobalReportReasons({
    required ReportEntityType reportEntityType,
  }) async =>
      _gqlClient
          .query(
            document: getReportReasonsQuery,
            variables: {
              'entity': reportEntityType.stringVal,
            },
            parseData: (json) => GqlReportReasonsListJson.fromJson(json),
          )
          .mapFailure(GetReportReasonsFailure.unknown)
          .mapSuccess(
            (reportReasons) => reportReasons.toDomain(),
          );

  @override
  Future<Either<CreateGlobalReportFailure, Unit>> createGlobalReport({
    required CreateReportInput report,
  }) async =>
      _gqlClient
          .mutate(
            document: createGlobalReportMutation,
            variables: {
              'info': report.toJson(),
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['createReport'] as Map<String, dynamic>),
          )
          .mapFailure(CreateGlobalReportFailure.unknown)
          .mapSuccessPayload(onFailureReturn: const CreateGlobalReportFailure.unknown());

  @override
  Future<Either<CreateCircleReportFailure, Unit>> createCircleReport({
    required ReportInput report,
  }) async =>
      _gqlClient
          .mutate(
            document: createCircleReportMutation,
            variables: {
              'reportInput': report.toJson(),
            },
            parseData: (json) => GqlSuccessPayload.fromJson(json['report'] as Map<String, dynamic>),
          )
          .mapFailure(CreateCircleReportFailure.unknown)
          .mapSuccessPayload(onFailureReturn: const CreateCircleReportFailure.unknown());
}
