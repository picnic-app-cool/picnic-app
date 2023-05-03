import 'package:flutter/material.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

mixin DateTimePickerRoute {
  Future<DateTime?> openDateTimePickerRoute({
    required DateTime currentTime,
  }) async {
    final date = await showDatePicker(
      context: AppNavigator.currentContext,
      initialDate: currentTime,
      firstDate: DateTime(currentTime.year),
      // ignore: prefer-trailing-comma
      lastDate: DateTime(currentTime.year, currentTime.month, currentTime.day),
    );

    if (date == null) {
      return null;
    }

    // ignore: use_build_context_synchronously
    final time = await showTimePicker(
      context: AppNavigator.currentContext,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) {
      return null;
    }

    // ignore: prefer-trailing-comma
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
