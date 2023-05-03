const String getLanguagesListQuery = """
query listLanguages(\$filter: LanguageFilter!){
  listLanguages(filter: \$filter){
      iso3
      flag
      name
      nativeName
      tag
      enabled
      base
  }
}
""";
