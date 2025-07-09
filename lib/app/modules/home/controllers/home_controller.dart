import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var username = 'User'.obs;
  var queueNumber = 0.obs;
  var feedbacks = <Map<String, dynamic>>[].obs;
  var promos = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchQueueNumber();
    fetchFeedbacks();
    fetchPromos();
  }

  void fetchUserData() {
    final box = GetStorage();
    username.value = box.read('username') ?? 'User';
  }

  Future<void> fetchQueueNumber() async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/antrian'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        queueNumber.value = data['queue_number'] ?? 0;
      } else {
        Get.snackbar('Gagal', 'Gagal mengambil data antrian');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
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
