import 'package:intl/intl.dart';

class ShopItemModel {
  static final _fmt =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

  String name;
  String desc;
  String image;
  int price; // harga dasar (satuan)
  int qty;
  List<String> extras;
  String note;
  late String priceLabel; // ← simpan string harga sekali

  ShopItemModel({
    required this.name,
    required this.desc,
    required this.image,
    required this.price,
    this.qty = 1,
    this.extras = const [],
    this.note = '',
  }) {
    priceLabel = _fmt.format(price);
  }

  /// panggil ini kalau harga berubah
  void refreshPriceLabel() => priceLabel = _fmt.format(price);
}
