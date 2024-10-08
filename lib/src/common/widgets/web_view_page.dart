import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ttd_learner/src/common/services/custom_snackbar_service.dart';
import 'package:ttd_learner/src/features/auth/controllers/auth_controller.dart';
import 'package:ttd_learner/src/utils/colors.dart';

class WebViewPage extends StatefulWidget {
  String url;
  String? authToken;
  String title;
  String pageName;
  String method;
  String refCode;
  WebViewPage({
    Key? key,
    required this.url,
    this.authToken = "",
    required this.title,
    this.pageName = "",
    this.method = 'GET',
    this.refCode = "",
  }) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    Map<String, String> body = {
      "code": widget.refCode,
    };
    String jsonBody = jsonEncode(body);
    Uint8List bodyBytes = Uint8List.fromList(utf8.encode(jsonBody));
    return WillPopScope(
      onWillPop: () async {
        var isLastPage = await inAppWebViewController.canGoBack();
        if (isLastPage) {
          inAppWebViewController.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: zBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
              if (widget.pageName == 'subscription') {
                AuthController.instance.validateUser();
              }
            },
          ),
          backgroundColor: zBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(color: zTextColor),
          ),
          iconTheme: const IconThemeData(color: zTextColor),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri(
                    widget.url +
                        '?code=${widget.refCode}' +
                        '&accessToken=' +
                        widget.authToken!,
                  ),
                  method: widget.method,
                  headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ${widget.authToken}',
                  },
                  body: widget.method == 'POST' ? bodyBytes : null,
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  inAppWebViewController = controller;
                },
                onLoadStop: (controller, url) async {
                  // Evaluate JavaScript to fetch and print JSON responses
                  var jsonResponse = await controller.evaluateJavascript(
                    source: "document.body.innerText",
                  );
                  if (jsonResponse != null) {
                    print("JSON Response from $url: $jsonResponse");
                    var decoded = jsonDecode(jsonResponse);
                    print(decoded['success']);
                    print(decoded['message']);
                    if (decoded['success'] == true) {
                      if (decoded['message'] == "Payment Successful!") {
                        CustomSnackBarService().showSuccessSnackBar(
                          message: "Payment Successful!",
                        );
                        AuthController.instance.validateUser();
                      }
                    }
                  }
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
                onUpdateVisitedHistory: (InAppWebViewController controller,
                    Uri? url, bool? androidIsReload) {
                  if (url.toString() ==
                      'https://api.incheckfit.com/payment/success') {
                    CustomSnackBarService().showSuccessSnackBar(
                      message: "Payment Successful!",
                    );
                    AuthController.instance.validateUser();
                  }
                },
              ),
              _progress < 1
                  ? LinearProgressIndicator(
                      color: zPrimaryColor,
                      value: _progress,
                      backgroundColor: zPrimaryColor.withOpacity(0.2),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
