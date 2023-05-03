import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/language.dart';

class GqlLanguageJson {
  const GqlLanguageJson({
    required this.tag,
    required this.name,
    required this.base,
    required this.iso3,
    required this.nativeName,
    required this.flag,
    required this.enabled,
  });

  factory GqlLanguageJson.fromJson(Map<String, dynamic>? json) => GqlLanguageJson(
        tag: asT<String>(json, 'tag'),
        name: asT<String>(json, 'name'),
        base: asT<String>(json, 'base'),
        iso3: asT<String>(json, 'iso3'),
        nativeName: asT<String>(json, 'nativeName'),
        flag: asT<String>(json, 'flag'),
        enabled: asT<bool>(json, 'enabled'),
      );

  final String tag;
  final String name;
  final String base;
  final String iso3;
  final String nativeName;
  final String flag;
  final bool enabled;

  Language toDomain() => Language(
        title: nativeName.toLowerCase(),
        code: tag,
        flag: flag,
      );
}
