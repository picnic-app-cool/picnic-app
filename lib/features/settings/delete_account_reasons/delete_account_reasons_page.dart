import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_presentation_model.dart';
import 'package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_presenter.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class DeleteAccountReasonsPage extends StatefulWidget with HasPresenter<DeleteAccountReasonsPresenter> {
  const DeleteAccountReasonsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final DeleteAccountReasonsPresenter presenter;

  @override
  State<DeleteAccountReasonsPage> createState() => _DeleteAccountReasonsPageState();
}

class _DeleteAccountReasonsPageState extends State<DeleteAccountReasonsPage>
    with PresenterStateMixin<DeleteAccountReasonsViewModel, DeleteAccountReasonsPresenter, DeleteAccountReasonsPage> {
  @override
  Widget build(BuildContext context) {
    return stateObserver(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: state.reasons.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () => presenter.onTapSelectReason(state.reasons[index]),
              title: Text(
                state.reasons[index].title,
                style: PicnicTheme.of(context).styles.body20,
              ),
            );
          },
        ),
      ),
    );
  }
}
