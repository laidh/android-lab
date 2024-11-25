import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserScreen extends StatefulWidget {
  final String url;
  final String title;

  BrowserScreen({required this.url, required this.title});

  @override
  BrowserScreenState createState() => BrowserScreenState();
}

class BrowserScreenState extends State<BrowserScreen> {
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
