import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:recaptcha_verification/recaptcha_verification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _verificationToken;
  final _recaptchaVerificationPlugin = RecaptchaVerification();
  Future<void> _recaptchaWebview(BuildContext context) async {
    setState(() => _verificationToken = '');

    final windowSize = MediaQuery.of(context).size;
    final pixelRation = MediaQuery.of(context).devicePixelRatio;
    String verificationToken;
    try {
      const siteKey = "Paste site key here";
      verificationToken = await _recaptchaVerificationPlugin.repcaptchaVerification(
        RecaptchaArgs.webview(
          siteKey: siteKey,
          width: (windowSize.width * 0.9 * pixelRation).toInt(),
          height: (windowSize.height * 0.8 * pixelRation).toInt(),
        ),
      );
    } on PlatformException {
      verificationToken = 'Failed to verify user';
    }

    setState(() => _verificationToken = verificationToken);
  }

  Future<void> _recaptchaAndroid() async {
    setState(() => _verificationToken = '');

    String verificationToken;
    try {
      const siteKey = "Paste site key here";
      verificationToken = await _recaptchaVerificationPlugin.repcaptchaVerification(
        const RecaptchaArgs.android(siteKey: siteKey),
      );
    } on PlatformException {
      verificationToken = 'Failed to verify user';
    }

    setState(() => _verificationToken = verificationToken);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('reCaptcha verification'),
        ),
        body: Builder(
          builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_verificationToken != null) Text(_verificationToken!),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: () => _recaptchaWebview(context),
                  child: const Text('Verify user with webview'),
                ),
              ),
              if (Platform.isAndroid)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: _recaptchaAndroid,
                    child: const Text('Verify user on Android'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
