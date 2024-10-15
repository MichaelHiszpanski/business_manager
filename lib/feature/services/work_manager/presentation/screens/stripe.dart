import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class StripePricingTableWidget extends StatefulWidget {
  const StripePricingTableWidget({Key? key}) : super(key: key);

  @override
  _StripePricingTableWidgetState createState() =>
      _StripePricingTableWidgetState();
}

class _StripePricingTableWidgetState extends State<StripePricingTableWidget> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    // You can load HTML once the controller is created
  }

  Future<String> _loadHtmlFromAssets() async {
    // This method loads the HTML content from the assets folder
    return await rootBundle.loadString('assets/myfile.html');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadHtmlFromAssets(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return WebView(
            initialUrl: '',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
              _loadHtmlContent(snapshot.data!);
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error loading pricing table"));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void _loadHtmlContent(String htmlContent) {
    _controller.loadUrl(
      Uri.dataFromString(
        htmlContent,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ).toString(),
    );
  }
}
