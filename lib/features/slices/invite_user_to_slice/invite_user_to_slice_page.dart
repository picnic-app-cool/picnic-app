// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/widgets/searchable_paginated_users_list_view.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_presentation_model.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class InviteUserToSlicePage extends StatefulWidget with HasPresenter<InviteUserToSlicePresenter> {
  const InviteUserToSlicePage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final InviteUserToSlicePresenter presenter;

  @override
  State<InviteUserToSlicePage> createState() => _InviteUserToSlicePageState();
}

class _InviteUserToSlicePageState extends State<InviteUserToSlicePage>
    with PresenterStateMixin<InviteUserToSliceViewModel, InviteUserToSlicePresenter, InviteUserToSlicePage> {
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
