import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/features/seeds/domain/model/election_candidate.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class CandidatesListWidget extends StatelessWidget {
  const CandidatesListWidget({
    Key? key,
    required this.directors,
    required this.selectedDirector,
    required this.loadMore,
    required this.onTapDirector,
  }) : super(key: key);

  final PaginatedList<ElectionCandidate> directors;
  final Selectable<ElectionCandidate> selectedDirector;
  final Future<void> Function() loadMore;
  final ValueChanged<ElectionCandidate> onTapDirector;

  @override
  Widget build(BuildContext context) => Expanded(
        child: PicnicPagingListView<ElectionCandidate>(
          paginatedList: directors,
          loadMore: loadMore,
          loadingBuilder: (context) => const PicnicLoadingIndicator(),
          itemBuilder: (context, director) {
            return _DirectorWidget(
              director: director,
              isSelected: selectedDirector.selected && selectedDirector.item == director,
              isVoted: director.iVoted,
              onDirectorTap: () => onTapDirector(director),
            );
          },
        ),
      );
}

class _DirectorWidget extends StatelessWidget {
  const _DirectorWidget({
    Key? key,
    required this.director,
    required this.isSelected,
    required this.isVoted,
    required this.onDirectorTap,
  }) : super(key: key);

  final ElectionCandidate director;
  final bool isSelected;
  final bool isVoted;
  final VoidCallback onDirectorTap;

  static const double _avatarSize = 42;
  static const _textColor = Color(0xFF45BAEC); //todo reuse from theme

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;

    final bwShade100 = colors.blackAndWhite.shade100;
    final greenShade500 = colors.green.shade500;

    final borderColor = isSelected
        ? colors.blue.shade300
        : isVoted
            ? greenShade500
            : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: PicnicListItem(
        setBoxShadow: true,
        fillColor: bwShade100,
        title: director.username,
        titleStyle: styles.title10.copyWith(color: colors.blackAndWhite.shade900),
        picnicTag: isVoted
            ? PicnicTag(
                title: appLocalizations.circleElectionYouVoted,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                backgroundColor: greenShade500,
                titleTextStyle: styles.body0.copyWith(
                  color: bwShade100,
                ),
                opacity: 1,
              )
            : null,
        borderColor: borderColor,
        leading: PicnicAvatar(
          backgroundColor: colors.blackAndWhite.shade300,
          size: _avatarSize,
          boxFit: PicnicAvatarChildBoxFit.cover,
          imageSource: PicnicImageSource.url(
            director.profilePictureUrl,
            fit: BoxFit.cover,
          ),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              director.percentage.formattedPercentage,
              style: styles.title30.copyWith(color: _textColor),
            ),
            Text(
              appLocalizations.votesCountFormat(director.votesCount),
              style: styles.caption10.copyWith(
                color: colors.darkBlue.shade500,
              ),
            ),
          ],
        ),
        onTap: isVoted ? null : onDirectorTap,
      ),
    );
  }
}
