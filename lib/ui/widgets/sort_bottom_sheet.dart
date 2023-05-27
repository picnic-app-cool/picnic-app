import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/buttons/picnic_sort_button.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class SortBottomSheet<T> extends StatelessWidget {
  const SortBottomSheet({
    required this.onTapSort,
    required this.onTapClose,
    required this.sortOptions,
    required this.selectedSortOption,
    required this.valueToDisplay,
    super.key,
  });

  final void Function(T) onTapSort;
  final void Function() onTapClose;
  final List<T> sortOptions;
  final T selectedSortOption;
  final String Function(T) valueToDisplay;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              appLocalizations.sortPostsBy,
              style: styles.subtitle40,
            ),
          ),
          ...sortOptions.map(
            (option) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: PicnicSortButton(
                label: valueToDisplay(option),
                isSelected: selectedSortOption == option,
                onTap: () => onTapSort(option),
              ),
            ),
          ),
          const Gap(16),
          const Divider(height: 1),
          const Gap(8),
          Center(
            child: PicnicTextButton(
              label: appLocalizations.closeAction,
              onTap: onTapClose,
            ),
          ),
        ],
      ),
    );
  }
}
