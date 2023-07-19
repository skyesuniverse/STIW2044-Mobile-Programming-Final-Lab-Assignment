import 'dart:async';
import 'package:barterit_app_final/models/user.dart';
import 'package:barterit_app_final/myconfig.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BillScreen extends StatefulWidget {
  final User user;
  final double finaltotalprice;

  const BillScreen({
    Key? key,
    required this.user,
    required this.finaltotalprice,
  }) : super(key: key);

  @override
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    final url = Uri.encodeFull(
        'http://192.168.0.145/barterit_final/php/payment.php?' +
            'email=${widget.user.email}&' +
            'name=${widget.user.name}&' +
            'userid=${widget.user.id}&' +
            'amount=${widget.finaltotalprice}&' +
            'sellerid=${widget.user.id}');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bill"),
      ),
      body: Center(
        child: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
        ),
      ),
    );
  }
}
