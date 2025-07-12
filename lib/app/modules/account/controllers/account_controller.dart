import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AccountController extends GetxController {
  var userName = ''.obs;
  var userPhone = ''.obs;
  var userImage = ''.obs;

  late TextEditingController feedbackController;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    feedbackController = TextEditingController();
    fetchUserData(); // load user data saat controller dibuat
  }

  @override
  void onClose() {
    feedbackController.dispose();
    super.onClose();
  }

  void fetchUserData() {
    final box = GetStorage();
    userName.value = box.read('username') ?? 'User';
    userPhone.value = box.read('phone') ?? '';
    userImage.value = box.read('image') ?? '';
    print('DEBUG image_url: ${userImage.value}');
    // 🔥 load URL foto
  }

  void logout() {
    final box = GetStorage();
    box.erase(); // hapus semua data user
    userName.value = '';
    userPhone.value = '';
    userImage.value = '';

    Get.snackbar(
      'Keluar',
      'Anda telah berhasil logout',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );

    Get.offAllNamed('/login');
  }

  Future<void> submitFeedback() async {
    final message = feedbackController.text.trim();
    final username = GetStorage().read('username') ?? 'User';

    if (message.isEmpty) {
      Get.snackbar('Gagal', 'Feedback tidak boleh kosong');
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/feedback'),
        headers: {'Accept': 'application/json'},
        body: {'message': message, 'username': username},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Sukses', 'Feedback berhasil dikirim');
        feedbackController.clear();
      } else {
        Get.snackbar('Gagal', 'Gagal mengirim feedback');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
