import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final obscurePass = true.obs;
  final agreeTerms = false.obs;
  final passwordLength = 0.obs;

  final box = GetStorage();
  final baseUrl = 'http://127.0.0.1:8000'; // ganti sesuai IP backend

  void toggleObscure() => obscurePass.toggle();
  void toggleAgree() => agreeTerms.toggle();

  @override
  void onInit() {
    super.onInit();
    passwordController.addListener(() {
      passwordLength.value = passwordController.text.length;
    });
  }

  bool _isValidForm() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordController.text.length >= 8 &&
        agreeTerms.value;
  }

  Future<void> register() async {
    if (passwordController.text.length < 8) {
      Get.snackbar('Gagal', 'Password minimal 8 karakter',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (!_isValidForm()) {
      Get.snackbar('Gagal', 'Lengkapi data & setujui S&K',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading(true);
    final url = Uri.parse('$baseUrl/api/register');

    try {
      final response = await http.post(url, headers: {
        'Accept': 'application/json',
      }, body: {
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'password': passwordController.text,
        'password_confirmation': passwordController.text,
      });

      final data = json.decode(response.body);

      if (response.statusCode == 201) {
        await box.write('token', data['token']);
        Get.snackbar('Berhasil', 'Pendaftaran sukses',
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed('/login');
      } else {
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

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
