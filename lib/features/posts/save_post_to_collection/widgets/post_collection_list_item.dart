import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/ui/widgets/picnic_collection_card.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PostCollectionListItem extends StatelessWidget {
  const PostCollectionListItem({
    super.key,
    required this.postCollection,
    required this.onTap,
  });

  final Collection postCollection;
  final VoidCallback onTap;

  static const _height = 48.0;
  static const _leadingImageBorderRadius = 8.0;
  static const _leadingImageSizeDimension = 32.0;
  static const _assetHorizontalPadding = 1.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return PicnicListItem(
      height: _height,
      title: postCollection.title,
      titleStyle: theme.styles.title10,
      onTap: onTap,
      leading: SizedBox.square(
        dimension: _leadingImageSizeDimension,
        child: PicnicCollectionCard(
          images: postCollection.thumbnails,
          collection: postCollection,
          showPostCount: false,
          borderRadius: _leadingImageBorderRadius,
          assetHorizontalPadding: _assetHorizontalPadding,
          onTap: onTap,
        ),
      ),
    );
  }
}
