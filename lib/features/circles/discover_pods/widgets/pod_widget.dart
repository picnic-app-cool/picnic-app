import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PodWidget extends StatelessWidget {
  const PodWidget({
    Key? key,
    required this.pod,
    required this.onTap,
    required this.width,
    required this.height,
  }) : super(key: key);

  final PodApp pod;
  final VoidCallback onTap;
  final double width;
  final double height;

  static const radius = 16.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final themeColors = theme.colors;
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width,
            height: width,
            child: PicnicImage(
              placeholder: () => Image.asset(Assets.images.podPlaceholderImg.path),
              source: PicnicImageSource.url(
                ImageUrl(pod.imageUrl),
                borderRadius: radius,
                width: width,
                height: height,
              ),
            ),
          ),
          Text(
            pod.name,
            style: theme.styles.body20.copyWith(color: themeColors.darkBlue),
          ),
          const Gap(2.0),
          Text(
            pod.owner.name,
            style: const TextStyle(
              fontSize: 12.0,
              color: Color.fromRGBO(
                57,
                72,
                124,
                0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
