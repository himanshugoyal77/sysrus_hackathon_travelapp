import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DirectionsPage extends StatefulWidget {
  const DirectionsPage({super.key});

  @override
  State<DirectionsPage> createState() => _DirectionsPageState();
}

class _DirectionsPageState extends State<DirectionsPage> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://spiffy-lebkuchen-96f5d6.netlify.app/'));

    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: h,
        child: ClipRRect(child: WebViewWidget(controller: controller)),
      ),
    );
  }
}
