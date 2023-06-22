import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/social_accounts/domain/social_network.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/paging_list/paging_grid_view.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class UnlinkedSocialNetworks extends StatelessWidget {
  const UnlinkedSocialNetworks({
    required this.socialNetworksList,
    required this.headlineStyle,
    required this.onTapSocialNetwork,
  });

  final PaginatedList<SocialNetwork> socialNetworksList;
  final TextStyle headlineStyle;
  final Function(SocialNetwork) onTapSocialNetwork;

  static const _columns = 3;
  static const _spacing = 8.0;
  static const _circleBorderRadius = 12.0;
  static const _socialNetworkSize = 40.0;
  static const _socialNetworkItemAspectRatio = 1.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.connectAccounts,
          style: headlineStyle,
        ),
        const Gap(8),
        Expanded(
          child: PagingGridView<SocialNetwork>(
            paging: socialNetworksList,
            columns: _columns,
            aspectRatio: _socialNetworkItemAspectRatio,
            loadMore: () => Future.value(),
            mainAxisSpacing: _spacing,
            crossAxisSpacing: _spacing,
            loadingBuilder: (_) => const Center(
              child: PicnicLoadingIndicator(),
            ),
            itemBuilder: (context, index) {
              final socialNetwork = socialNetworksList.items[index];
              return GestureDetector(
                onTap: () => onTapSocialNetwork(socialNetwork),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_circleBorderRadius),
                    color: PicnicColors.liteGrey,
                  ),
                  child: Center(
                    child: Image.asset(
                      socialNetwork.assetImagePath,
                      width: _socialNetworkSize,
                      height: _socialNetworkSize,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
