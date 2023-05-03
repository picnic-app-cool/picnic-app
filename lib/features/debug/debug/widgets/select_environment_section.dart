import 'package:flutter/material.dart';
import 'package:picnic_app/core/environment_config/environment_config_slug.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class SelectEnvironmentSection extends StatelessWidget {
  const SelectEnvironmentSection({
    super.key,
    required this.environments,
    required this.selectedEnvironment,
    required this.onTapEnvironment,
  });

  final List<EnvironmentConfigSlug> environments;
  final EnvironmentConfigSlug selectedEnvironment;
  final ValueChanged<EnvironmentConfigSlug> onTapEnvironment;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyles = theme.styles;
    const fontSize = 20.0;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colors.blackAndWhite.shade500,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "Select backend environment",
                style: textStyles.title20,
              ),
            ),
            ...environments.map(
              (it) {
                final selected = it == selectedEnvironment;
                return Row(
                  children: [
                    Opacity(
                      opacity: selected ? 1 : 0,
                      child: const Icon(Icons.arrow_circle_right_sharp),
                    ),
                    PicnicTextButton(
                      label: it.name,
                      labelStyle: TextStyle(
                        fontSize: fontSize,
                        fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                      ),
                      onTap: () => onTapEnvironment(it),
                    ),
                  ],
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
