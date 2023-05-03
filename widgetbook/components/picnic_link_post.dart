//Figma Link :
//https://www.figma.com/file/6jHfRx6qqnUyQ25IWCziNK/Picnic-Redesign?node-id=4%3A623

import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/link_url.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/features/posts/domain/model/link_metadata.dart';
import 'package:picnic_app/ui/widgets/picnic_link_post.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicLinkPostUseCases extends WidgetbookComponent {
  PicnicLinkPostUseCases()
      : super(
          name: "$PicnicLinkPost",
          useCases: [
            WidgetbookUseCase(
              name: "Link Post use Cases",
              builder: (context) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: PicnicLinkPost(
                        linkUrl: LinkUrl(context.knobs.text(label: 'Post URL', initialValue: 'www.google.com')),
                        linkMetadata: LinkMetadata(
                          host: context.knobs.text(label: 'Post URL', initialValue: 'www.google.com'),
                          title: context.knobs.text(label: 'Title', initialValue: 'How to organize my room'),
                          imageUrl: context.knobs.options(
                            label: 'Image URL',
                            options: [
                              const Option(
                                label: 'Milkshake',
                                value: ImageUrl(
                                  'https://firebasestorage.googleapis.com/v0/b/amber-app-supercool.appspot.com/o/mock-images%2Fpost_drink.webp?alt=media&token=',
                                ),
                              ),
                              const Option(
                                label: 'Food',
                                value: ImageUrl(
                                  'https://firebasestorage.googleapis.com/v0/b/amber-app-supercool.appspot.com/o/mock-images%2Fpost_chicken.webp?alt=media&token=',
                                ),
                              ),
                            ],
                          ),
                          description: context.knobs.text(label: 'description', initialValue: 'Some nice description'),
                          url: "",
                        ),
                        onTap: (url) => doNothing(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
}
