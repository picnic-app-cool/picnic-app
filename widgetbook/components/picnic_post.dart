import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/features/posts/domain/model/posts/content_stats_for_content.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/ui/widgets/picnic_post/picnic_post.dart';
import 'package:widgetbook/widgetbook.dart';

import '../constants/widgetbook_constants.dart';

class PicnicPostUseCases extends WidgetbookComponent {
  PicnicPostUseCases()
      : super(
          name: "$PicnicPost",
          useCases: [
            WidgetbookUseCase(
              name: "Post Use Cases",
              builder: (context) {
                const storageBaseUrl = "https://storage.googleapis.com/amber-app-supercool.appspot.com/mock-images/";
                return PicnicPost(
                  background: context.knobs.options(
                    label: 'Background (Image Left Half)',
                    description:
                        "Choose between color gradients and images. Also serves as left half of split image post",
                    options: [
                      Option(
                        label: "Blue Linear Gradient",
                        value: BoxDecoration(
                          gradient: WidgetBookConstants.picnicPostGradientBlue,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      Option(
                        label: "Green Linear Gradient",
                        value: BoxDecoration(
                          gradient: WidgetBookConstants.picnicPostGradientGreen,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      Option(
                        label: "Gold Linear Gradient",
                        value: BoxDecoration(
                          gradient: WidgetBookConstants.picnicPostGradientGold,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      Option(
                        label: "Pink Linear Gradient",
                        value: BoxDecoration(
                          gradient: WidgetBookConstants.picnicPostGradientPink,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      Option(
                        label: "Purple Linear Gradient",
                        value: BoxDecoration(
                          gradient: WidgetBookConstants.picnicPostGradientPurple,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      Option(
                        label: "Image: Lounge",
                        value: BoxDecoration(
                          image: const DecorationImage(
                            image: NetworkImage("${storageBaseUrl}post_lounge.webp"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      Option(
                        label: "Image: Girl",
                        value: BoxDecoration(
                          image: const DecorationImage(
                            image: NetworkImage("${storageBaseUrl}post_girl.webp"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      const Option(
                        label: "Image Left Half",
                        value: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("${storageBaseUrl}post_chicken.webp"),
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            topLeft: Radius.circular(24),
                          ),
                        ),
                      ),
                    ],
                  ),
                  backgroundRightHalf: context.knobs.options(
                    label: 'Image Right Half',
                    options: [
                      const Option(
                        label: "Image 2",
                        value: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("${storageBaseUrl}post_beer.webp"),
                          ),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                      )
                    ],
                  ),
                  title: context.knobs.options(
                    label: 'Title',
                    options: [
                      const Option(label: "None", value: ""),
                      const Option(
                        label: "Short",
                        value: "How to organize my room",
                      )
                    ],
                  ),
                  bodyText: context.knobs.options(
                    label: 'Body Text',
                    options: [
                      const Option(
                        label: "Description",
                        value:
                            "Omg that midterm was terrible. Blah blah blah blah... Did anyone else think it was bad or was it just me :((",
                      ),
                      const Option(label: "None", value: ""),
                      const Option(
                        label: "Long",
                        value:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                      )
                    ],
                  ),
                  onTapExpand: context.knobs.options(
                    label: 'Expand OnTap',
                    options: [
                      Option(
                        label: "Enabled",
                        value: () {},
                      ),
                      const Option(
                        label: "Disabled",
                        value: null,
                      )
                    ],
                  ),
                  addBackgroundShadow: context.knobs.options(
                    label: 'Vertical: Shadow',
                    options: [
                      const Option(
                        label: "None",
                        value: false,
                      ),
                      const Option(
                        label: "Yes",
                        value: true,
                      ),
                    ],
                  ),
                  dimension: context.knobs.options(
                    label: 'Post Dimension',
                    options: [
                      const Option(
                        label: "Horizontal",
                        value: PicnicPostDimension.horizontal,
                      ),
                      const Option(
                        label: "Vertical",
                        value: PicnicPostDimension.vertical,
                      ),
                      const Option(
                        label: "Vertical Gallery",
                        value: PicnicPostDimension.verticalGallery,
                      ),
                    ],
                  ),
                  post: const Post.empty().copyWith(
                    circle: const BasicCircle.empty().copyWith(
                      name: context.knobs.text(
                        label: 'Tag Title',
                        initialValue: '🚀 startups',
                      ),
                    ),
                    author: const BasicPublicProfile.empty().copyWith(
                      username: context.knobs.text(
                        label: 'Username',
                        initialValue: 'payamdaliri',
                      ),
                    ),
                    contentStats: const ContentStatsForContent.empty().copyWith(
                      impressions: context.knobs
                          .number(
                            label: 'Views Count',
                            initialValue: 3581,
                          )
                          .toInt(),
                    ),
                  ),
                  subTitle: context.knobs.options(
                    label: 'Subtitle',
                    options: [
                      const Option(
                        label: "None",
                        value: null,
                      ),
                      const Option(
                        label: "Text",
                        value: "link.com",
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
}
