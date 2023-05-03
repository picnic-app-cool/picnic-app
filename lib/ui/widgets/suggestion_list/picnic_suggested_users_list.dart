import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_app/ui/widgets/suggestion_list/picnic_suggested_users_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicSuggestedUsersList extends StatelessWidget {
  const PicnicSuggestedUsersList({
    required this.suggestedUsersToMention,
    required this.onTapSuggestedMention,
    this.onChanged,
    this.textController,
    this.focusNode,
    this.profileStats,
    super.key,
  });

  final PaginatedList<UserMention> suggestedUsersToMention;
  final ValueChanged<UserMention> onTapSuggestedMention;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final ProfileStats? profileStats;

  static const _borderRadius = 16.0;
  static const _blurRadius = 30.0;
  static const _shadowOpacity = 0.07;

  @override
  Widget build(BuildContext context) {
    final list = suggestedUsersToMention.items;
    final borderRadius = BorderRadius.circular(_borderRadius);
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: colors.blackAndWhite.shade100,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              blurRadius: _blurRadius,
              color: colors.blackAndWhite.shade900.withOpacity(_shadowOpacity),
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(12),
              if (onChanged != null && textController != null) ...[
                PicnicTextInput(
                  focusNode: focusNode,
                  prefix: Image.asset(Assets.images.searchGlass.path),
                  textController: textController,
                  hintText: appLocalizations.tagAfriendOrContactHint,
                  onChanged: onChanged,
                  padding: 0,
                  inputFillColor: colors.blackAndWhite.shade200,
                ),
              ],
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final user = list[index];

                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => onTapSuggestedMention(user),
                    child: PicnicSuggestedUsersListItem(
                      user: user,
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Gap(24),
                itemCount: list.length,
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
