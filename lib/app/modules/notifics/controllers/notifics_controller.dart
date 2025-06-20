import 'package:get/get.dart';

class NotificsController extends GetxController {
  // Contoh properti yang bisa dikembangkan nanti
  var itemCount = 0.obs;

  void addItem() {
    itemCount++;
  }

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi awal bisa ditambahkan di sini
  }
}
