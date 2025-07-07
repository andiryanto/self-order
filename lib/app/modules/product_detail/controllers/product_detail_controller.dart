import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../shop/controllers/shop_controller.dart';
import '../../shop/models/shop_item_model.dart';

class ProductDetailController extends GetxController {
  /* ------------ Data produk dasar ------------ */
  late final String productName;
  late final String productDesc;
  late final int basePrice;
  late final String imagePath;

  /* ------------ Kuantitas ------------ */
  final RxInt qty = 1.obs;
  void incQty() => qty.value++;
  void decQty() {
    if (qty.value > 1) qty.value--;
  }

  /* ------------ Topping / Extra ------------ */
  final extras = <String, int>{
    'ExtraShot': 8000,
    'Topping Kopi Jelly': 8000,
    'Topping Nata d Coco': 8000,
    'Topping Regal': 5000,
  };
  final selectedExtras = <String>[].obs;

  void toggleExtra(String e) => selectedExtras.contains(e)
      ? selectedExtras.remove(e)
      : selectedExtras.add(e);

  int get extrasPrice => selectedExtras.fold(0, (t, e) => t + extras[e]!);

  /* ------------ Catatan ------------ */
  final RxString note = ''.obs;
  void setNote(String v) => note.value = v;

  /* ------------ Harga total ------------ */
  static final _fmt =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
  int get totalPrice => (basePrice + extrasPrice) * qty.value;
  String get totalPriceLabel => _fmt.format(totalPrice);

  /* ------------ Cart ------------ */
  final ShopController cart = Get.find<ShopController>();

  @override
  void onInit() {
    super.onInit();
    final args = (Get.arguments ?? {}) as Map<String, dynamic>;

    productName = args['name']?.toString() ?? 'Americano';
    productDesc = args['desc']?.toString() ?? 'Kopi hitam tanpa gula';
    basePrice = switch (args['price']) {
      int p => p,
      String s => int.tryParse(s) ?? 18000,
      _ => 18000,
    };
    final img = args['image']?.toString() ?? '';
    imagePath = img.startsWith('http')
        ? img
        : img.isNotEmpty
            ? 'http://192.168.0.10:8000/storage/$img'
            : 'assets/images/cup.jpg';
  }

  void addToCart() {
    cart.add(ShopItemModel(
      name: productName,
      desc: [
        productDesc,
        if (selectedExtras.isNotEmpty) '+ ${selectedExtras.join(", ")}',
        if (note.value.isNotEmpty) '(Catatan: ${note.value})'
      ].join('\n'),
      image: imagePath,
      price: basePrice + extrasPrice,
      qty: qty.value,
    ));

    Get.back();
    Get.showSnackbar(const GetSnackBar(
      title: 'Berhasil',
      message: 'Produk ditambahkan ke keranjang',
      backgroundColor: Color(0xFF000000),
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(12),
      borderRadius: 8,
    ));
  }
}
