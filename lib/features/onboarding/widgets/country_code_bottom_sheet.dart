import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/country_with_dial_code.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/bottom_sheet_top_indicator.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CountryCodeBottomSheet extends StatefulWidget {
  const CountryCodeBottomSheet({
    required this.countriesList,
    required this.onTapCountry,
  });

  final List<CountryWithDialCode> countriesList;
  final void Function(CountryWithDialCode) onTapCountry;

  @override
  State<StatefulWidget> createState() => _CountryCodeBottomSheetState();
}

class _CountryCodeBottomSheetState extends State<CountryCodeBottomSheet> {
  late List<CountryWithDialCode> countries;
  static const _dividerHeight = 1.0;
  static const _heightFactor = 0.9;

  @override
  void initState() {
    super.initState();
    countries = widget.countriesList;
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final darkBlue = theme.colors.darkBlue;
    final styles = theme.styles;
    final nameStyle = styles.body40.copyWith(color: darkBlue.shade800);
    return FractionallySizedBox(
      heightFactor: _heightFactor,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            BottomSheetTopIndicator(),
            const Gap(20),
            PicnicSoftSearchBar(
              hintText: appLocalizations.searchCountries,
              onChanged: _onSearchQueryChanged,
            ),
            const Gap(16),
            Container(
              width: double.infinity,
              height: _dividerHeight,
              color: darkBlue.shade300,
            ),
            const Gap(16),
            Expanded(
              child: ListView.separated(
                itemCount: countries.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Gap(16),
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return GestureDetector(
                    onTap: () => _onTapCountry(country),
                    child: Row(
                      children: [
                        Text(
                          country.flag,
                          style: nameStyle,
                        ),
                        const Gap(4),
                        Expanded(
                          child: Text(
                            country.name,
                            style: nameStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          country.code,
                          style: styles.body30.copyWith(color: darkBlue.shade600),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSearchQueryChanged(String searchQuery) {
    setState(() {
      countries = widget.countriesList
          .where(
            (country) =>
                country.name.toLowerCase().contains(searchQuery.toLowerCase()) || country.code.contains(searchQuery),
          )
          .toList();
    });
  }

  void _onTapCountry(CountryWithDialCode country) {
    widget.onTapCountry(country);
    Navigator.of(context).pop();
  }
}
