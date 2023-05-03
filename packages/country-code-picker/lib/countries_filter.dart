import 'package:country_code_picker/country_code_picker.dart';

abstract class CountriesFilter {
  List<CountryCode> filter(List<CountryCode> allContries, String query);
}
