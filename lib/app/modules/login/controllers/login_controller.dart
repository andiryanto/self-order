import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_order/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final obscurePassword = true.obs;
  final isLoading = false.obs;

  final box = GetStorage();
  final baseUrl = 'http://127.0.0.1:8000';

  void togglePasswordVisibility() => obscurePassword.toggle();

  Future<void> login() async {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Mohon lengkapi semua data',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading(true);
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/api/login'),
        body: {'phone': phone, 'password': password},
      );

      print('STATUS CODE: ${res.statusCode}');
      print('RESPONSE BODY: ${res.body}');
      print('RESPONSE HEADERS: ${res.headers}');

      final contentType = res.headers['content-type'] ?? '';

      if (contentType.contains('application/json')) {
        final data = json.decode(res.body);

        if (res.statusCode == 200 && data['token'] != null) {
          // ✅ Login berhasil
          await box.write('token', data['token']);
          await box.write('username', data['user']['name']);
          await box.write('phone', data['user']['phone']);
          await box.write('image', data['user']['profile_photo_url'] ?? '');

          Get.offAllNamed(Routes.HOME_MAIN);
          Get.snackbar('Sukses', 'Login berhasil',
              duration: Duration(seconds: 3),
              backgroundColor: Colors.green,
              colorText: Colors.white);
        } else {
          // ❌ Login gagal
          final errorMsg = data['message'] ??
              (res.statusCode == 401
                  ? 'Nomor HP atau password salah'
                  : 'Login gagal');
          Get.snackbar('Gagal', errorMsg,
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        // 🔴 Server kirim selain JSON
        Get.snackbar('Error',
            'Server tidak mengirimkan data JSON\nCode: ${res.statusCode}',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print("Login error: $e");
      Get.snackbar('Error', 'Terjadi kesalahan saat login\n${e.toString()}',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
