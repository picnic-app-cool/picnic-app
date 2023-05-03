// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_presentation_model.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_presenter.dart';
import 'package:picnic_app/features/circles/widgets/searchable_paginated_users_list_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/status_bars/light_status_bar.dart';

class AddMembersListPage extends StatefulWidget with HasPresenter<AddMembersListPresenter> {
  const AddMembersListPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final AddMembersListPresenter presenter;

  @override
  State<AddMembersListPage> createState() => _AddMembersListPageState();
}

class _AddMembersListPageState extends State<AddMembersListPage>
    with PresenterStateMixin<AddMembersListViewModel, AddMembersListPresenter, AddMembersListPage> {
  @override
  Widget build(BuildContext context) {
    return LightStatusBar(
      child: stateObserver(
        builder: (context, state) => SafeArea(
          child: SearchablePaginatedUsersListView(
            title: appLocalizations.addMemberTitle,
            buttonTitle: appLocalizations.addAction,
            selectedButtonTitle: appLocalizations.addActionDone,
            onSearchTextChanged: presenter.onSearchTextChanged,
            onTapClose: presenter.onTapClose,
            onTapUserButton: presenter.onTapAdd,
            users: state.users,
            loadMore: presenter.loadMore,
          ),
        ),
      ),
    );
  }
}
