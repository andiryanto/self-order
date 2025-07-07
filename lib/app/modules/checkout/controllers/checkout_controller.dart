// lib/app/modules/checkout/controllers/checkout_controller.dart
import 'package:get/get.dart';
import '../../shop/controllers/shop_controller.dart';

class CheckoutController extends GetxController {
  final shopC = Get.find<ShopController>();
  RxInt subtotal = 0.obs;

  @override
  void onInit() {
    super.onInit();
    countSubtotal();
  }

  void countSubtotal() {
    int total = 0;
    for (var item in shopC.items) {
      total += item.price * item.qty;
    }
    subtotal.value = total;
  }

  void toPayment() {
    // Nanti ke halaman payment, sementara belum ada
    // Get.toNamed('/payment');
  }
}
