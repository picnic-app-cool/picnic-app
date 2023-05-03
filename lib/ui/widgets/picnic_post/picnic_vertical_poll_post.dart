import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';

class PicnicVerticalPollPost extends StatelessWidget {
  const PicnicVerticalPollPost({
    Key? key,
    required this.leftImageUrl,
    required this.rightImageUrl,
  }) : super(key: key);

  final ImageUrl leftImageUrl;
  final ImageUrl rightImageUrl;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: PicnicImage(
              source: PicnicImageSource.url(
                leftImageUrl,
                fit: BoxFit.cover,
                height: double.infinity,
              ),
            ),
          ),
          Expanded(
            child: PicnicImage(
              source: PicnicImageSource.url(
                rightImageUrl,
                fit: BoxFit.cover,
                height: double.infinity,
              ),
            ),
          ),
        ],
      );
}
