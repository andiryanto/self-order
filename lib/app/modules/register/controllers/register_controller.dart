import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class RegisterController extends GetxController {
  /* ---------- Text Editing Controllers ---------- */
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  /* ---------- UI State ---------- */
  final isLoading = false.obs;
  final obscurePass = true.obs;
  final agreeTerms = false.obs;

  /* ---------- Local Storage & Base URL ---------- */
  final box = GetStorage();
  final baseUrl = 'http://127.0.0.1:8000'; // ganti sesuai IP backend

  /* ---------- Helper Toggle ---------- */
  void toggleObscure() => obscurePass.toggle();
  void toggleAgree() => agreeTerms.toggle();

  /* ---------- REGISTER ACTION ---------- */
  Future<void> register() async {
    if (!_isValidForm()) {
      Get.snackbar('Gagal', 'Lengkapi data & setujui S&K',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading(true);
    final url = Uri.parse('$baseUrl/api/register');

    try {
      final response = await http.post(url, body: {
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'password': passwordController.text,
        'password_confirmation': passwordController.text,
      });

      final data = json.decode(response.body);

      if (response.statusCode == 201) {
        // success → simpan token & navigasi
        await box.write('token', data['token']);
        Get.snackbar('Berhasil', 'Pendaftaran sukses',
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed('/home-main');
      } else {
        // gagal → tampilkan pesan dari server
        final msg = data['message'] ?? 'Terjadi kesalahan';
        Get.snackbar('Gagal', msg,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  /* ---------- FORM VALIDATION ---------- */
  bool _isValidForm() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        agreeTerms.value;
  }

  /* ---------- CLEANUP ---------- */
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
