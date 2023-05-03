import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CountrySelectFormPresentationModel implements CountrySelectFormViewModel {
  /// Creates the initial state
  CountrySelectFormPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CountrySelectFormInitialParams initialParams,
  )   : countryCode = initialParams.formData.country,
        onCountrySelectedCallback = initialParams.onCountrySelected;

  /// Used for the copyWith method
  CountrySelectFormPresentationModel._({
    required this.onCountrySelectedCallback,
    required this.countryCode,
  });

  final ValueChanged<String> onCountrySelectedCallback;
  @override
  final String countryCode;

  CountrySelectFormPresentationModel copyWith({
    ValueChanged<String>? onCountrySelectedCallback,
    String? countryCode,
  }) {
    return CountrySelectFormPresentationModel._(
      onCountrySelectedCallback: onCountrySelectedCallback ?? this.onCountrySelectedCallback,
      countryCode: countryCode ?? this.countryCode,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CountrySelectFormViewModel {
  String get countryCode;
}
