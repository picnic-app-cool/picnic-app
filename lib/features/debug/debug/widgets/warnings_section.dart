import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WarningsSection extends StatelessWidget {
  const WarningsSection({
    super.key,
    required this.hasCustomHeaders,
    required this.usesShortLivedTokens,
  });

  final bool hasCustomHeaders;
  final bool usesShortLivedTokens;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasCustomHeaders)
          const _WarningMessage(
            text:
                "You have custom headers set, if you encounter any problems with backend, make sure to first clear them",
          ),
        if (usesShortLivedTokens)
          const _WarningMessage(
            text: "You've enabled short-lived auth tokens, if you're not testing token refresh, please disable"
                " this option to save some bandwidth for your app and backend",
          ),
      ],
    );
  }
}

class _WarningMessage extends StatelessWidget {
  const _WarningMessage({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.amber.shade700,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            8.0,
            16.0,
            16.0,
            16.0,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.warning,
                color: Colors.white,
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
