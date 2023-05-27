import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/debug/debug/widgets/additional_header_row.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class AdditionalHeadersSection extends StatelessWidget {
  const AdditionalHeadersSection({
    super.key,
    required this.additionalHeaders,
    required this.onTapDeleteHeader,
    required this.onTapEditHeader,
    required this.onTapAddHeader,
  });

  final Map<String, String> additionalHeaders;
  final ValueChanged<MapEntry<String, String>> onTapDeleteHeader;
  final ValueChanged<MapEntry<String, String>> onTapEditHeader;
  final VoidCallback onTapAddHeader;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyles = theme.styles;
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
                "Additional GraphQL Headers",
                style: textStyles.subtitle30,
              ),
            ),
            Text(
              "here you can specify additional HTTP headers that will be added to every query and mutation in graphQL. "
              "This is useful if you want to test on various feature environments specified in backend",
              style: textStyles.caption10,
            ),
            const Gap(16),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "Key",
                      style: textStyles.subtitle20,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Value",
                      style: textStyles.subtitle20,
                    ),
                  ),
                ),
              ],
            ),
            if (additionalHeaders.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("No additional headers specified"),
                ),
              ),
            ...additionalHeaders.entries.map(
              (header) => AdditionalHeaderRow(
                header: header,
                onTapDelete: () => onTapDeleteHeader(header),
              ),
            ),
            const Gap(16),
            PicnicButton(title: "Add header", onTap: onTapAddHeader),
          ],
        ),
      ),
    );
  }
}
