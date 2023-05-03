// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/debug/log_console/log_console_presentation_model.dart';
import 'package:picnic_app/features/debug/log_console/log_console_presenter.dart';
import 'package:picnic_app/features/debug/log_console/widgets/buttons_row.dart';
import 'package:picnic_app/features/debug/log_console/widgets/log_list_view.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';

class LogConsolePage extends StatefulWidget with HasPresenter<LogConsolePresenter> {
  const LogConsolePage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final LogConsolePresenter presenter;

  @override
  State<LogConsolePage> createState() => _LogConsolePageState();
}

class _LogConsolePageState extends State<LogConsolePage>
    with PresenterStateMixin<LogConsoleViewModel, LogConsolePresenter, LogConsolePage> {
  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return stateObserver(
      builder: (context, state) {
        const logWidth = 1700.0;
        return Scaffold(
          appBar: const PicnicAppBar(
            titleText: "Log Console",
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: logWidth,
                child: LogListView(state: state),
              ),
            ),
          ),
          floatingActionButton: ButtonsRow(presenter: presenter),
        );
      },
    );
  }
}
