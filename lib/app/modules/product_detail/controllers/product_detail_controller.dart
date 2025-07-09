import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../shop/controllers/shop_controller.dart';
import '../../shop/models/shop_item_model.dart';

class ProductDetailController extends GetxController {
  late final String productName;
  late final String productDesc;
  late final int basePrice;
  late final String imagePath;

  final RxInt qty = 1.obs;
  void incQty() => qty.value++;
  void decQty() {
    if (qty.value > 1) qty.value--;
  }

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

  int get extrasPrice => selectedExtras.fold(0, (t, e) => t + (extras[e] ?? 0));

  final RxString note = ''.obs;
  void setNote(String v) => note.value = v;

  static final _fmt =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
  int get totalPrice => (basePrice + extrasPrice) * qty.value;
  String get totalPriceLabel => _fmt.format(totalPrice);

  final ShopController cart = Get.find<ShopController>();

  @override
  void onInit() {
    super.onInit();
    final args = (Get.arguments ?? {}) as Map<String, dynamic>;

    productName = args['name']?.toString() ?? 'Americano';
    productDesc = args['desc']?.toString() ?? 'Kopi hitam tanpa gula';
    print('ARG PRICE: ${args['price']}');
    basePrice = _parseHarga(args['price']);
    imagePath = (args['image']?.toString().isNotEmpty ?? false)
        ? args['image'].toString()
        : 'assets/images/cup.jpg';

    if (args['extras'] is Map<String, dynamic>) {
      final rawExtras = args['extras'] as Map<String, dynamic>;
      extras.clear();
      rawExtras.forEach((k, v) => extras[k] = _parseHarga(v));
    }
  }

  int _parseHarga(dynamic value) {
    if (value == null) return 0;

    if (value is int) return value;

    if (value is double) return value.toInt();

    if (value is String) {
      final parsed = double.tryParse(value.replaceAll(',', ''));
      return parsed != null ? parsed.toInt() : 0;
    }

    return 0;
  }

  void addToCart() {
    cart.add(ShopItemModel(
      name: productName,
      desc: productDesc,
      image: imagePath,
      price: basePrice + extrasPrice,
      qty: qty.value,
      extras: List<String>.from(selectedExtras), // ✅ penting: salin extras
      note: note.value, // ✅ salin note juga
    ));

    Get.back();
    Get.snackbar(
      'Berhasil',
      'Produk ditambahkan ke keranjang',
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
