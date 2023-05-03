import 'dart:convert';

typedef ValueChanged<T> = void Function(T);
typedef VoidCallback = void Function();

/// toJson method extracted to top-level function to be used with `compute`
String toJsonMethod(Map<String, dynamic> obj) => jsonEncode(obj);

/// fromJson method extracted to top-level function to be used with `compute`
Map<String, dynamic> fromJsonMethod(String json) => jsonDecode(json) as Map<String, dynamic>;
