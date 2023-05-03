import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';

/// Gap between the top of the feed page and post content.
/// This gap is reserved for feed's appbar.
class PostInFeedNavbarGap extends StatelessWidget {
  const PostInFeedNavbarGap();

  @override
  Widget build(BuildContext context) {
    return const Gap(Constants.postInFeedNavBarGapHeight);
  }
}
