import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/features/circles/widgets/users_paginated_list_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SearchablePaginatedUsersListView extends StatelessWidget {
  const SearchablePaginatedUsersListView({
    Key? key,
    required this.title,
    required this.buttonTitle,
    required this.selectedButtonTitle,
    required this.users,
    required this.loadMore,
    required this.onTapUserButton,
    required this.onTapClose,
    required this.onSearchTextChanged,
    this.focusNode,
    this.controller,
    this.buttonColor,
  }) : super(key: key);

  final String title;
  final String buttonTitle;
  final String selectedButtonTitle;
  final Color? buttonColor;
  final PaginatedList<Selectable<PublicProfile>> users;
  final Future<void> Function() loadMore;
  final Function(PublicProfile) onTapUserButton;
  final VoidCallback onTapClose;
  final Function(String) onSearchTextChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final closeImagePath = Assets.images.close.path;
    return Scaffold(
      appBar: PicnicAppBar(
        iconPathLeft: closeImagePath,
        child: Text(
          title,
          style: PicnicTheme.of(context).styles.subtitle30,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: PicnicSoftSearchBar(
              controller: controller,
              onChanged: onSearchTextChanged,
              hintText: appLocalizations.chatNewMessageSearchInputHint,
              focusNode: focusNode,
            ),
          ),
          UsersPaginatedListView(
            usersList: users,
            loadMore: loadMore,
            onTapAdd: onTapUserButton,
            buttonTitle: buttonTitle,
            selectedButtonTitle: selectedButtonTitle,
            buttonColor: buttonColor,
          ),
        ],
      ),
    );
  }
}
