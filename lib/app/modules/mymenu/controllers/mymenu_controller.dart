import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MymenuController extends GetxController {
  var username = 'Ryan'.obs;
  var selectedOrderType = 'Takeaway'.obs;
  final orderTypeOptions = ['Takeaway', 'Dine In'];

  var isLoading = false.obs;
  var menus = [].obs; // List langsung tanpa model

  @override
  void onInit() {
    super.onInit();
    fetchMenus(); // Panggil API saat controller aktif
  }

  void fetchMenus() async {
    try {
      isLoading(true);
      final response =
          await http.get(Uri.parse('http://127.0.0.1:8000/api/menus'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        menus.value = jsonData['data']; // ← langsung assign list
      } else {
        Get.snackbar('Gagal', 'Gagal mengambil data menu');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
