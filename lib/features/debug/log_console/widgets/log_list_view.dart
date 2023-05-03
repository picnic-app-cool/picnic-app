import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/debug/log_console/log_console_presentation_model.dart';

class LogListView extends StatelessWidget {
  const LogListView({
    super.key,
    required this.state,
  });

  final LogConsoleViewModel state;
  static const fontSize = 12.0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        bottom: 100,
      ),
      itemBuilder: (context, index) {
        final entry = state.logEntries[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: entry.lines
              .map(
                (line) => Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  width: double.infinity,
                  child: Text(
                    line,
                    style: TextStyle(
                      color: _color(entry.level),
                      fontSize: fontSize,
                      fontFeatures: const [
                        FontFeature.tabularFigures(),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
      itemCount: logMemory.buffer.length,
    );
  }

  Color _color(Level level) {
    switch (level) {
      case Level.verbose:
        return Colors.blueGrey.shade500;
      case Level.debug:
        return Colors.blueGrey.shade800;
      case Level.info:
        return Colors.blue.shade900;
      case Level.warning:
        return Colors.deepOrange.shade800;
      case Level.error:
        return Colors.red.shade700;
      case Level.wtf:
        return Colors.redAccent.shade700;
      case Level.nothing:
        return Colors.blueGrey.shade500;
    }
  }
}
