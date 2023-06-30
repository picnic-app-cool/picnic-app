import 'package:picnic_app/core/domain/model/country_with_dial_code.dart';
import 'package:picnic_app/features/onboarding/widgets/country_code_bottom_sheet.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

mixin CountryCodePickerRoute {
  Future<void> showCountryCodePickerBottomSheet({
    required List<CountryWithDialCode> countriesList,
    required void Function(CountryWithDialCode) onTapCountry,
  }) async {
    return showPicnicBottomSheet(
      CountryCodeBottomSheet(
        countriesList: countriesList,
        onTapCountry: onTapCountry,
      ),
    );
  }

  AppNavigator get appNavigator;
}
