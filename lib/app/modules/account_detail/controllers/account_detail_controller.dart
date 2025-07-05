import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:self_order/app/data/models/user_model.dart';

class AccountDetailController extends GetxController {
  // Ambil user global dan jadikan observable
  final Rx<UserModel> user = Get.find<UserModel>().obs;

  late TextEditingController usernameC;
  late TextEditingController emailC;
  late TextEditingController phoneC;

  final _picker = ImagePicker();
  final Rx<File?> imageFile = Rx<File?>(null);
  bool isPicking = false;

  @override
  void onInit() {
    super.onInit();
    usernameC = TextEditingController(text: user.value.name);
    emailC = TextEditingController(text: user.value.email);
    phoneC = TextEditingController(text: user.value.phone);
  }

  // ----------------- GANTI FOTO -----------------
  Future<void> pickImage() async {
    if (isPicking) return;
    isPicking = true;

    try {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        imageFile.value = File(picked.path);
        user.update((u) => u?.image = picked.path);
      }
    } catch (e) {
      debugPrint('Image picker error: $e');
    } finally {
      isPicking = false;
    }
  }

  // ----------------- SIMPAN PROFIL -----------------
  Future<void> saveProfile() async {
    user.update((u) {
      if (u != null) {
        u.name = usernameC.text;
        u.email = emailC.text;
        u.phone = phoneC.text;
        // gender sudah di-update di view (dropdown)
        if (imageFile.value != null) {
          u.image = imageFile.value!.path;
        }
      }
    });

    Get.snackbar(
      'Sukses',
      'Profil berhasil disimpan',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  // ----------------- HAPUS AKUN -----------------
  Future<void> deleteAccount() async {
    Get.defaultDialog(
      title: 'Hapus Akun',
      middleText: 'Yakin mau hapus akun?',
      textConfirm: 'Ya',
      textCancel: 'Tidak',
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      buttonColor: Colors.black,
      onConfirm: () {
        Get.back();
        Get.snackbar(
          'Info',
          'Akun dihapus',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Get.offAllNamed('/login');
      },
    );
  }
}
