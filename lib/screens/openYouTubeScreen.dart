import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class OpenYouTube extends StatefulWidget {
  const OpenYouTube({super.key});

  static const String routeName = 'openYouTube';

  @override
  State<StatefulWidget> createState() {
    return _OpenYouTubeState();
  }
}

class _OpenYouTubeState extends State<OpenYouTube> {
  late final WebViewController _controller;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.youtube.com/'));
  }

  final TextEditingController urlTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    urlTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _loadHtmlFromAssets();
    return Scaffold(
      appBar: AppBar(
        title: Text('Webview Demo'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }

  _loadHtmlFromAssets() async {
    await _controller.loadRequest(Uri.parse('https://www.youtube.com/'));
  }
}
