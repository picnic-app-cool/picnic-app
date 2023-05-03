import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/debug/log_console/log_console_presenter.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  final LogConsolePresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton.extended(
          heroTag: null,
          onPressed: presenter.onTapClear,
          label: const Text("clear"),
          icon: const Icon(Icons.clear),
        ),
        const Gap(4),
        FloatingActionButton.extended(
          heroTag: null,
          onPressed: presenter.onTapRefresh,
          label: const Text("refresh"),
          icon: const Icon(Icons.refresh),
        ),
        const Gap(4),
        FloatingActionButton.extended(
          heroTag: null,
          onPressed: presenter.onTapSend,
          label: const Text("send"),
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}
