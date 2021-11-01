import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../routes.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage(
      {required this.html,
      required this.title,
      this.uri = true,
      this.paymentMethodPage = false});

  final String html;
  final String title;
  final bool uri;
  final bool paymentMethodPage;

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title, style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            if (Navigator.of(context).canPop() &&
                widget.paymentMethodPage == true) {
              Navigator.of(context)
                  .popUntil((route) => route.settings.name == Routes.home);
            } else {
              Navigator.of(context).maybePop();
            }
          },
        ),
      ),
      body: WebView(
        initialUrl: widget.uri
            ? Uri.dataFromString(widget.html, mimeType: 'text/html').toString()
            : widget.html,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {
          print("WebView is loading (progress : $progress%)");
        },
        navigationDelegate: (NavigationRequest request) {
          print('Navigation delegate');
          print(request.url);
          if (Platform.isAndroid) {
            if (!request.url.contains('intent://') &&
                request.url.contains('pay-result')) {
              launch(request.url);
            }
          }
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
          if (url.contains('deep_link_id')) {
            launch(url);
          }
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        gestureNavigationEnabled: true,
      ),
    );
  }
}
