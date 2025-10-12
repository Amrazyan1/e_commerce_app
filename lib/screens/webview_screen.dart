import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/blocs/orders/bloc/orders_bloc.dart';
import 'package:e_commerce_app/blocs/orders/bloc/orders_event.dart';
import 'package:e_commerce_app/router/router.gr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class WebviewScreen extends StatefulWidget {
  final String link;
  final void Function(String)? onUrlChanged;
  const WebviewScreen({super.key, required this.link, this.onUrlChanged});

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
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(widget.link),
              ),
              onWebViewCreated: (controller) {},
              onPermissionRequest: _onPermissionRequest,
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                final uri = navigationAction.request.url;
                log("⚠️ Attempting to navigate to: $uri");

                if (uri.toString().contains("orderCallback")) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    if (widget.onUrlChanged == null) {
                      context.read<OrdersBloc>().add(FetchOrders());
                      AutoRouter.of(context).navigate(const EmptyRouter(children: [OrdersRoute()]));
                    }
                  }
                  return NavigationActionPolicy.CANCEL;
                }
                if (uri!.toString().startsWith("idramapp://") ||
                    uri.toString().startsWith("idramappjr://")) {
                  try {
                    final canLaunchApp = await canLaunchUrl(uri);

                    if (canLaunchApp) {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    }
                  } catch (e) {
                    log("Error launching deep link: $e");
                  }
                  return NavigationActionPolicy.CANCEL;
                }

                return NavigationActionPolicy.ALLOW;
              },
              initialSettings: InAppWebViewSettings(
                isInspectable: kDebugMode,
                useHybridComposition: true,
                mediaPlaybackRequiresUserGesture: false,
                javaScriptEnabled: true,
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
          ),
        ],
      ),
    );
  }
}
