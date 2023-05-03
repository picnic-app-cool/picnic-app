// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_presentation_model.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_presenter.dart';
import 'package:picnic_app/features/circles/widgets/searchable_paginated_users_list_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class InviteUserListPage extends StatefulWidget with HasPresenter<InviteUserListPresenter> {
  const InviteUserListPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final InviteUserListPresenter presenter;

  @override
  State<InviteUserListPage> createState() => _InviteUserListPageState();
}

class _InviteUserListPageState extends State<InviteUserListPage>
    with PresenterStateMixin<InviteUserListViewModel, InviteUserListPresenter, InviteUserListPage> {
  @override
  Widget build(BuildContext context) {
    return stateObserver(
      builder: (context, state) => SearchablePaginatedUsersListView(
        title: appLocalizations.inviteUsersAction,
        buttonTitle: appLocalizations.inviteAction,
        selectedButtonTitle: appLocalizations.inviteActionDone,
        onSearchTextChanged: presenter.onSearchTextChanged,
        onTapClose: presenter.onTapClose,
        onTapUserButton: presenter.onTapInvite,
        users: state.users,
        loadMore: presenter.loadMore,
      ),
    );
  }
}
