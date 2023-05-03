import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_presentation_model.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_presenter.dart';
import 'package:picnic_app/features/slices/join_requests/widgets/join_requests_list.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class JoinRequestsPage extends StatefulWidget with HasPresenter<JoinRequestsPresenter> {
  const JoinRequestsPage({
    super.key,
    required this.presenter,
  });

  @override
  final JoinRequestsPresenter presenter;

  @override
  State<JoinRequestsPage> createState() => _JoinRequestsPageState();
}

class _JoinRequestsPageState extends State<JoinRequestsPage>
    with PresenterStateMixin<JoinRequestsViewModel, JoinRequestsPresenter, JoinRequestsPage> {
  final TextEditingController _controller = TextEditingController();
  static const _padding = EdgeInsets.symmetric(horizontal: 16.0);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => presenter.onJoinRequestsSearch(_controller.text));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return Scaffold(
      appBar: PicnicAppBar(
        backgroundColor: theme.colors.blackAndWhite.shade100,
        titleText: appLocalizations.joinRequestsPageTitle,
      ),
      body: Padding(
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: PicnicSoftSearchBar(
                hintText: appLocalizations.search,
                controller: _controller,
              ),
            ),
            const Gap(16),
            stateObserver(
              builder: (context, state) => Expanded(
                child: JoinRequestsList(
                  onTapApprove: presenter.onTapApprove,
                  onTapViewUserProfile: presenter.onTapUser,
                  requests: state.joinRequests,
                  loadMoreRequests: presenter.loadPendingRequests,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
