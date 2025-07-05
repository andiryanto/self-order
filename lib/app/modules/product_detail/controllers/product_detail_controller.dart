import 'dart:collection';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  /* --- DATA PRODUK (bisa dikirim via Get.arguments) --- */
  final String productName = Get.arguments?['name'] ?? 'Americano';
  final String productDesc = Get.arguments?['desc'] ?? 'Kopi hitam tanpa gula';
  final int basePrice = Get.arguments?['price'] ?? 18000;
  final String imagePath = Get.arguments?['image'] ?? 'assets/images/cup.png';

  /* --- EXTRA / TOPPING --- */
  final Map<String, int> _extras = {
    'Ekstra Shot': 8000,
    'Topping Kopi Jelly': 8000,
    'Topping Nata d\'Coco': 8000,
    'Topping Regal': 5000,
  };

  /// baca‐saja map harga extra
  UnmodifiableMapView<String, int> get extras => UnmodifiableMapView(_extras);

  /// extra yang dipilih
  final RxSet<String> selectedExtras = <String>{}.obs;

  /* --- QUANTITY --- */
  final RxInt qty = 1.obs;

  /* --- TOTAL PRICE --- */
  int get totalPrice {
    final extrasTotal =
        selectedExtras.fold<int>(0, (sum, e) => sum + (_extras[e] ?? 0));
    return (basePrice + extrasTotal) * qty.value;
  }

  /* ------------ ACTIONS ------------ */
  void toggleExtra(String name) {
    if (selectedExtras.contains(name)) {
      selectedExtras.remove(name);
    } else {
      selectedExtras.add(name);
    }
  }

  void incQty() => qty.value++;
  void decQty() {
    if (qty.value > 1) qty.value--;
  }

  void addToCart() {
    // TODO: panggil service keranjang
    Get.snackbar('Berhasil', '$productName dimasukkan keranjang');
  }
}
