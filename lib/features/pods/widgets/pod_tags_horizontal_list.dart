import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/app_tag.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PodTagsHorizontalList extends StatelessWidget {
  const PodTagsHorizontalList({required this.tags});

  final List<AppTag> tags;

  static const radius = 16.0;
  static const double _tagsBorderRadius = 8.0;
  static const double _tagsHeight = 22.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    return SizedBox(
      height: _tagsHeight,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        separatorBuilder: (context, index) => const Gap(8),
        itemBuilder: (BuildContext context, int index) {
          final tag = tags[index];
          return PicnicTag(
            opacity: 1.0,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            titleHeight: 1.0,
            title: tag.name,
            borderRadius: _tagsBorderRadius,
            backgroundColor: colors.darkBlue.shade300,
            titleTextStyle: theme.styles.body10.copyWith(color: colors.darkBlue.shade800),
          );
        },
      ),
    );
  }
}
