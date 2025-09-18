import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

@RoutePage()
class WebviewScreen extends StatefulWidget {
  final String link;

  const WebviewScreen({super.key, required this.link});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  final double _progress = 0;
  Future<PermissionResponse> _onPermissionRequest(
    InAppWebViewController controller,
    PermissionRequest permissionRequest,
  ) async {
    return PermissionResponse(
      resources: permissionRequest.resources,
      action: PermissionResponseAction.GRANT,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Webview'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: _progress < 1.0
            ? PreferredSize(
                preferredSize: const Size.fromHeight(3),
                child: LinearProgressIndicator(value: _progress),
              )
            : null,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(widget.link),
        ),
        onWebViewCreated: (controller) {},
        onPermissionRequest: _onPermissionRequest,
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          final uri = navigationAction.request.url;
          log("⚠️ Attempting to navigate to: $uri");

          // // Example: Prevent external links and open them in browser instead
          // if (uri != null && !uri.toString().contains("yourdomain.com")) {
          //   log("🚫 Blocked external navigation: $uri");
          //   return NavigationActionPolicy.CANCEL;
          // }

          return NavigationActionPolicy.ALLOW;
        },
        initialSettings: InAppWebViewSettings(
          isInspectable: kDebugMode,
          useHybridComposition: false,
          mediaPlaybackRequiresUserGesture: false,
          allowsInlineMediaPlayback: true,
          clearSessionCache: true,
          clearCache: true,
          cacheEnabled: false,
          supportZoom: false,
          maximumZoomScale: 0,
          minimumZoomScale: 0,
          preferredContentMode: UserPreferredContentMode.MOBILE,
          transparentBackground: true,
          builtInZoomControls: false,
        ),
      ),
    );
  }
}
