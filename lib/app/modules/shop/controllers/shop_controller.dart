import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/shop_item_model.dart';

class ShopController extends GetxController {
  // ===== DATA =====
  final items = <ShopItemModel>[].obs;

  // ===== ORDER TYPE =====
  var orderType = 'Takeaway'.obs;

  void setOrderType(String type) {
    orderType.value = type;
  }

  // ===== FORMATTER =====
  static final _fmt = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  // ===== SUBTOTAL =====
  int get subtotal => items.fold(0, (sum, item) => sum + item.price * item.qty);
  String get subtotalLabel => _fmt.format(subtotal);

  String priceLabel(int price) => _fmt.format(price);

  bool get isEmpty => items.isEmpty;

  // ===== ACTIONS =====
  void add(ShopItemModel item) {
    final idx = items.indexWhere((e) => e.name == item.name);
    if (idx != -1) {
      items[idx].qty += item.qty;
      items[idx].price = item.price; // update harga terbaru
      items[idx].extras = item.extras; // update topping
      items[idx].note = item.note; // update catatan
    } else {
      items.add(item);
    }
    items.refresh();
  }

  void inc(int index) {
    items[index].qty++;
    items.refresh();
  }

  void dec(int index) {
    if (items[index].qty > 1) {
      items[index].qty--;
    } else {
      items.removeAt(index);
    }
    items.refresh();
  }

  void remove(int index) {
    items.removeAt(index);
    items.refresh();
  }

  void updateItem(int index, {String? note, List<String>? extras}) {
    final item = items[index];
    if (note != null) item.note = note;
    if (extras != null) item.extras = extras;
    items.refresh();
  }
}
