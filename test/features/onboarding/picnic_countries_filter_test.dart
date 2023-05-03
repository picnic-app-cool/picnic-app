import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/onboarding/widgets/picnic_countries_filter.dart';

void main() {
  test(
    'the country search should bring the correct results',
    () {
      const query = 'uni';
      const jsonList = codes;
      final allCountries = jsonList.map((json) => CountryCode.fromJson(json)).toList();
      const filter = PicnicCountriesFilter();

      final result = filter.filter(allCountries, query);

      // we are not able to compare CountryCode because it doesn't have equals method,
      // so we compare objects by country name
      final expected = [
        'La Réunion',
        'United Kingdom',
        'United States',
        'United States Virgin Islands',
      ];
      expect(result.map((e) => e.name), expected);
    },
  );
}
