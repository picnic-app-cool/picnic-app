import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PicnicWebView extends StatefulWidget {
  const PicnicWebView({super.key, required this.url});

  final String url;

  @override
  State<PicnicWebView> createState() => _PicnicWebViewState();
}

class _PicnicWebViewState extends State<PicnicWebView> {
  static const progressFinished = 100;

  late final WebViewController controller;
  int loadingPercentage = 0;

  @override
  void initState() {
    controller = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: _onPageLoadingStarted,
          onProgress: _onPageLoadingProgressChanged,
          onPageFinished: _onPageLoadingFinished,
          onNavigationRequest: _onNavigationRequest,
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(widget.url),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          controller: controller,
        ),
        if (loadingPercentage < progressFinished) const Center(child: PicnicLoadingIndicator()),
      ],
    );
  }

  void _onPageLoadingStarted(String url) {
    setState(() {
      loadingPercentage = 0;
    });
  }

  void _onPageLoadingProgressChanged(int progress) {
    setState(() {
      loadingPercentage = progress;
    });
  }

  void _onPageLoadingFinished(String url) {
    setState(() {
      loadingPercentage = progressFinished;
    });
  }

  NavigationDecision _onNavigationRequest(NavigationRequest request) {
    if (request.url.endsWith('finish')) {
      Navigator.of(context).pop();
      return NavigationDecision.prevent;
    } else {
      return NavigationDecision.navigate;
    }
  }
}
