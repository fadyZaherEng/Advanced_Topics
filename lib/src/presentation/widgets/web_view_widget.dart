import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends BaseStatefulWidget {
  final String webViewUrl;

  const WebViewWidget({Key? key, required this.webViewUrl}) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends BaseState<WebViewWidget> {
  bool isPageLoaded = false;
  WebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.webViewUrl,
              onPageFinished: (url) {
                setState(() {
                  isPageLoaded = true;
                });
              },
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
            ),
            isPageLoaded
                ? const SizedBox()
                : const Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
