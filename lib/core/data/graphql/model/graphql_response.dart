// To parse this JSON data, do
//
//     final graphQlResponse = graphQlResponseFromJson(jsonString);

/// General structure for graphQL response, it can contain data or error
class GraphQlResponse {
  GraphQlResponse({
    required this.data,
  });

  factory GraphQlResponse.fromJson(Map<String, dynamic> json) => GraphQlResponse(
        data: json["data"] == null ? json : json["data"] as Map<String, dynamic>,
      );

  final Map<String, dynamic> data;
}
