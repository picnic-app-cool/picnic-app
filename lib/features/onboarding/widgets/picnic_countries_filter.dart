import 'package:country_code_picker/countries_filter.dart';
import 'package:country_code_picker/country_code.dart';

class PicnicCountriesFilter implements CountriesFilter {
  const PicnicCountriesFilter();

  @override
  List<CountryCode> filter(List<CountryCode> allCountries, String query) {
    final search = query.toUpperCase();
    return allCountries
        .where(
          (element) =>
              element.toCountryStringOnly().toUpperCase().contains(search) ||
              element.toString().toUpperCase().contains(search),
        )
        .toList();
  }
}
