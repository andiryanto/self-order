import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var username = 'User'.obs;
  var queueNumber = 0.obs;
  var feedbacks = <Map<String, dynamic>>[].obs;
  var promos = <Map<String, dynamic>>[].obs; // ✅ tambahkan list promo

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchQueueNumber();
    fetchFeedbacks();
    fetchPromos(); // ✅ panggil di sini
  }

  void fetchUserData() {
    final box = GetStorage();
    username.value = box.read('username') ?? 'User';
  }

  void fetchQueueNumber() {
    queueNumber.value = 50; // Bisa disambung ke API kalau perlu
  }

  Future<void> fetchFeedbacks() async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/feedback'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        feedbacks.value = List<Map<String, dynamic>>.from(body);
      } else {
        Get.snackbar('Gagal', 'Gagal mengambil data feedback');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }

  // ✅ Fungsi baru untuk ambil data promo dari API
  Future<void> fetchPromos() async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/promo'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        promos.value = List<Map<String, dynamic>>.from(data);
      } else {
        Get.snackbar('Gagal', 'Gagal mengambil data promo');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }
}
