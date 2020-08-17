import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebviewPage extends StatefulWidget {
  const WebviewPage({Key key,this.url}) : super(key: key);
final String url;

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  final Completer<WebViewController> ctrl= Completer<WebViewController>(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: widget.url,
          onWebViewCreated: (WebViewController c)=>ctrl.complete(c),
        ),
      ),
    );
  }
}