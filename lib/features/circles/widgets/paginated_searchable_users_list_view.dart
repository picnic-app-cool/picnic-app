import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/features/circles/widgets/paginated_users_list_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PaginatedSearchableUsersListView extends StatelessWidget {
  const PaginatedSearchableUsersListView({
    Key? key,
    required this.title,
    required this.buttonTitle,
    required this.users,
    required this.onTapAdd,
    required this.onTapUser,
    required this.onTapClose,
    required this.onSearchTextChanged,
    required this.loadMore,
    this.focusNode,
    this.controller,
    this.buttonColor,
  }) : super(key: key);

  final String title;
  final String buttonTitle;
  final Color? buttonColor;
  final PaginatedList<PublicProfile> users;
  final Function(PublicProfile) onTapAdd;
  final Function(PublicProfile) onTapUser;
  final Future<void> Function() loadMore;
  final VoidCallback onTapClose;
  final Function(String) onSearchTextChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final themeData = PicnicTheme.of(context);
    final styles = themeData.styles;
    final colors = themeData.colors;

    final closeImagePath = Assets.images.close.path;
    return Scaffold(
      appBar: PicnicAppBar(
        backgroundColor: colors.blackAndWhite.shade100,
        iconPathLeft: closeImagePath,
        child: Text(
          title,
          style: styles.title20,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: PicnicSoftSearchBar(
              controller: controller,
              onChanged: onSearchTextChanged,
              hintText: appLocalizations.chatNewMessageSearchInputHint,
              focusNode: focusNode,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              appLocalizations.usersResults,
              style: styles.title30,
            ),
          ),
          PaginatedUsersListView(
            loadMore: loadMore,
            modsList: users,
            onTapAdd: onTapAdd,
            onTapUser: onTapUser,
            buttonTitle: buttonTitle,
            buttonColor: buttonColor,
          ),
        ],
      ),
    );
  }
}
