import 'dart:async';

import 'package:country_code_picker/country_codes.dart' as code_picker_codes;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryEditingController<T> extends TextEditingController {
  CountryEditingController({
    required Cubit<T> cubit,
    required String Function(T) countryCodeExtractor,
  }) {
    final country = _findCountryForCode(countryCodeExtractor(cubit.state));
    text = country['name']!;
    subscription = cubit.stream.listen((viewModel) {
      text = _findCountryForCode(countryCodeExtractor(cubit.state))['name']!;
    });
  }

  late StreamSubscription<T> subscription;

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  Map<String, String> _findCountryForCode(String code) {
    return code_picker_codes.codes.firstWhere(
      (element) => element['code'] == code,
      orElse: () => code_picker_codes.codes.firstWhere((element) => (element['code']?.trim().toLowerCase()) == 'us'),
    );
  }
}
