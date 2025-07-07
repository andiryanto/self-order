import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/shop_item_model.dart';

class ShopController extends GetxController {
  final items = <ShopItemModel>[].obs;

  /// Formatter untuk harga
  static final _fmt =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

  /// Subtotal semua item
  int get subtotal => items.fold(0, (sum, item) => sum + item.price * item.qty);
  String get subtotalLabel => _fmt.format(subtotal);

  /// Format harga individual
  String priceLabel(int price) => _fmt.format(price);

  /* ------------------ ACTIONS ------------------ */

  /// Tambah item baru ke keranjang (merge kalau sudah ada)
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

  /// Tambah qty
  void inc(int index) {
    items[index].qty++;
    items.refresh();
  }

  /// Kurangi qty (hapus jika qty 1)
  void dec(int index) {
    if (items[index].qty > 1) {
      items[index].qty--;
    } else {
      items.removeAt(index);
    }
    items.refresh();
  }

  /// Hapus item
  void remove(int index) {
    items.removeAt(index);
    items.refresh();
  }

  /// Update item topping/catatan
  void updateItem(int index, {String? note, List<String>? extras}) {
    final item = items[index];
    if (note != null) item.note = note;
    if (extras != null) item.extras = extras;
    items.refresh();
  }
}
