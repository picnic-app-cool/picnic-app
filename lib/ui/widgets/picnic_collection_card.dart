import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/utils/extensions/list_extension.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicCollectionCard extends StatelessWidget {
  const PicnicCollectionCard({
    Key? key,
    required this.images,
    required this.collection,
    required this.onTap,
    this.postCount = 0,
    this.showPostCount = true,
    this.borderRadius = _defaultBorderRadius,
    this.assetHorizontalPadding = _assetHorizontalPadding,
  }) : super(key: key);

  final List<ImageUrl> images;
  final Collection collection;
  final int postCount;
  final bool showPostCount;
  final double borderRadius;
  final double assetHorizontalPadding;
  final VoidCallback onTap;

  static const _defaultBorderRadius = 24.0;
  static const _primaryColumnFlex = 4;
  static const _secondaryColumnFlex = 3;
  static const _assetHorizontalPadding = 24.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CollectionCardImage(
                    imageSource: images.tryGet(0),
                    flex: _primaryColumnFlex,
                    assetHorizontalPadding: assetHorizontalPadding,
                  ),
                  const Gap(3),
                  Flexible(
                    flex: _secondaryColumnFlex,
                    child: Column(
                      children: [
                        _CollectionCardImage(
                          imageSource: images.tryGet(1),
                          assetHorizontalPadding: assetHorizontalPadding,
                        ),
                        const Gap(3),
                        _CollectionCardImage(
                          //ignore: no-magic-number
                          imageSource: images.tryGet(2),
                          assetHorizontalPadding: assetHorizontalPadding,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showPostCount) ...[
            const Gap(6),
            _BottomCollectionCardSection(
              collection: collection,
              postCount: postCount,
            ),
          ],
        ],
      ),
    );
  }
}

class _CollectionCardImage extends StatelessWidget {
  const _CollectionCardImage({
    required this.assetHorizontalPadding,
    this.imageSource,
    this.flex = 1,
    Key? key,
  }) : super(key: key);

  final ImageUrl? imageSource;
  final int flex;
  final double assetHorizontalPadding;

  @override
  Widget build(BuildContext context) {
    final themeColors = PicnicTheme.of(context).colors;
    final backgroundColor = themeColors.blackAndWhite.shade200;
    final emptyImage = Container(
      color: backgroundColor,
    );

    return Expanded(
      flex: flex,
      child: imageSource != null
          ? Builder(
              builder: (context) {
                final url = imageSource!.url;
                final isAsset = imageSource!.isAsset;

                return Container(
                  color: backgroundColor,
                  padding: isAsset ? EdgeInsets.symmetric(horizontal: assetHorizontalPadding) : null,
                  child: isAsset
                      ? Image.asset(
                          url,
                          height: double.infinity,
                        )
                      : Image.network(
                          url,
                          fit: BoxFit.cover,
                          height: double.infinity,
                        ),
                );
              },
            )
          : emptyImage,
    );
  }
}

class _BottomCollectionCardSection extends StatelessWidget {
  const _BottomCollectionCardSection({
    Key? key,
    required this.collection,
    this.postCount = 0,
  }) : super(key: key);

  final Collection collection;
  final int postCount;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyle = theme.styles.body10;

    final blackAndWhite = theme.colors.blackAndWhite;
    final isPrivate = !collection.isPublic;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (isPrivate) Assets.images.lock.image(color: blackAndWhite.shade900),
            Text(
              collection.title,
              style: textStyle.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          appLocalizations.collectionCardPostCountLabel(postCount),
          style: textStyle.copyWith(
            color: blackAndWhite.shade600,
          ),
        ),
      ],
    );
  }
}
