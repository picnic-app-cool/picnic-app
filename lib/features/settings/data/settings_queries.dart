String get getDocumentByKey => """
query documentGet(\$key: String!){
  documentGet(key: \$key)
}
""";
