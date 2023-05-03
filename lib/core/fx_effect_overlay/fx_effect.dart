import 'package:flutter/material.dart';

abstract class FxEffect {
  const FxEffect({required this.duration});

  final Duration duration;

  Widget build(BuildContext context);
}
