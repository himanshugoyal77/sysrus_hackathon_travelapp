import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://friendly-strudel-ca2b2e.netlify.app/'));

    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: h,
        child: ClipRRect(child: WebViewWidget(controller: controller)),
      ),
    );
  }
}
