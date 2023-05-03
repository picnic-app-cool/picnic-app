import 'package:country_code_picker/countries_filter.dart';
import 'package:country_code_picker/country_code.dart';

class DefaultCountriesFilter implements CountriesFilter {
  const DefaultCountriesFilter();

  @override
  List<CountryCode> filter(List<CountryCode> allContries, String query) => allContries
      .where((e) => e.code!.contains(query) || e.dialCode!.contains(query) || e.name!.toUpperCase().contains(query))
      .toList();
}
