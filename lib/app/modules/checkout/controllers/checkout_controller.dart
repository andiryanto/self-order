// lib/app/modules/checkout/controllers/checkout_controller.dart
import 'package:get/get.dart';
import '../../shop/controllers/shop_controller.dart';

class CheckoutController extends GetxController {
  /// Mengakses ShopController global
  final ShopController shopC = Get.find<ShopController>();

  /// Getter subtotal (total harga semua item)
  int get subtotal => shopC.subtotal;

  /// Fungsi lanjut ke pembayaran (sementara masih dummy)
  void toPayment() {
    Get.snackbar(
      'Checkout',
      'Fitur pembayaran belum tersedia.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}
