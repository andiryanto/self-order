import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_order/app/routes/app_pages.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final String redirectUrl = Get.arguments['redirect_url'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Payment',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..loadRequest(Uri.parse(redirectUrl))
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                if (url.contains('/payment/success')) {
                  Get.offAllNamed(Routes.HOME_MAIN);
                  Get.snackbar(
                    'Sukses',
                    'Pembayaran berhasil dilakukan!',
                    snackPosition: SnackPosition.TOP,
                    duration: Duration(seconds: 2),
                  );
                }
              },
            ),
          ),
      ),
    );
  }
}
