// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_presentation_model.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_presenter.dart';
import 'package:picnic_app/features/circles/widgets/paginated_searchable_users_list_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class BanUserListPage extends StatefulWidget with HasPresenter<BanUserListPresenter> {
  const BanUserListPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final BanUserListPresenter presenter;

  @override
  State<BanUserListPage> createState() => _BanUserListPageState();
}

class _BanUserListPageState extends State<BanUserListPage>
    with PresenterStateMixin<BanUserListViewModel, BanUserListPresenter, BanUserListPage> {
  @override
  Widget build(BuildContext context) {
    return stateObserver(
      builder: (context, state) => PaginatedSearchableUsersListView(
        buttonTitle: appLocalizations.banAction,
        buttonColor: PicnicTheme.of(context).colors.pink,
        title: appLocalizations.banUserLabel,
        onSearchTextChanged: presenter.onSearchTextChanged,
        onTapClose: presenter.onTapClose,
        onTapAdd: presenter.onTapBan,
        onTapUser: presenter.onTapUser,
        users: state.usersList,
        loadMore: presenter.loadMore,
      ),
    );
  }
}
