import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_presentation_model.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_presenter.dart';
import 'package:picnic_app/features/seeds/seed_recipients/widgets/recipients_list.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class SeedRecipientsPage extends StatefulWidget with HasPresenter<SeedRecipientsPresenter> {
  const SeedRecipientsPage({
    super.key,
    required this.presenter,
  });

  @override
  final SeedRecipientsPresenter presenter;

  @override
  State<SeedRecipientsPage> createState() => _SeedRecipientsPageState();
}

class _SeedRecipientsPageState extends State<SeedRecipientsPage>
    with PresenterStateMixin<SeedRecipientsViewModel, SeedRecipientsPresenter, SeedRecipientsPage> {
  late final TextEditingController _controller;
  static const _padding = EdgeInsets.all(20);
  static const _heightFactor = 0.7;
  static const _edgeInsets = EdgeInsets.symmetric(horizontal: 16.0);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() => presenter.onUserSearch(_controller.text));
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return FractionallySizedBox(
      heightFactor: _heightFactor,
      child: Padding(
        padding: _padding,
        child: stateObserver(
          buildWhen: (previous, current) => previous.recipients != current.recipients,
          builder: (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: _edgeInsets,
                child: Text(
                  appLocalizations.selectUser,
                  style: theme.styles.title30,
                  textAlign: TextAlign.left,
                ),
              ),
              const Gap(16),
              Padding(
                padding: _edgeInsets,
                child: PicnicSoftSearchBar(
                  hintText: appLocalizations.search,
                  controller: _controller,
                ),
              ),
              const Gap(16),
              RecipientsList(
                onTapSelectRecipient: presenter.onTapSelectRecipient,
                loadMore: presenter.loadMoreCircleMembers,
                recipients: state.recipients,
              ),
              Center(
                child: PicnicTextButton(
                  label: appLocalizations.cancelAction,
                  onTap: presenter.onTapClose,
                  labelStyle: theme.styles.body20.copyWith(color: theme.colors.blackAndWhite.shade600),
                ),
              ),
            ],
          ),
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
