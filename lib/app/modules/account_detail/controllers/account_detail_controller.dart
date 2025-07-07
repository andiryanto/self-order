import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';

class AccountDetailController extends GetxController {
  final box = GetStorage();

  late TextEditingController usernameC;
  late TextEditingController emailC;
  late TextEditingController phoneC;

  final RxString gender = ''.obs;
  final RxString imagePath = ''.obs;

  final _picker = ImagePicker();
  final Rx<File?> imageFile = Rx<File?>(null);
  bool isPicking = false;

  @override
  void onInit() {
    super.onInit();
    usernameC = TextEditingController(text: box.read('username') ?? '');
    emailC = TextEditingController(text: box.read('email') ?? '');
    phoneC = TextEditingController(text: box.read('phone') ?? '');
    gender.value = box.read('gender') ?? 'Male';
    imagePath.value = box.read('image') ?? '';
  }

  // ----------------- GANTI FOTO -----------------
  Future<void> pickImage() async {
    if (isPicking) return;
    isPicking = true;

    try {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        imageFile.value = File(picked.path);
        imagePath.value = picked.path;
        box.write('image', picked.path);
      }
    } catch (e) {
      debugPrint('Image picker error: $e');
    } finally {
      isPicking = false;
    }
  }

  // ----------------- SIMPAN PROFIL -----------------
  Future<void> saveProfile() async {
    box.write('username', usernameC.text);
    box.write('email', emailC.text);
    box.write('phone', phoneC.text);
    box.write('gender', gender.value);
    if (imageFile.value != null) {
      box.write('image', imageFile.value!.path);
    }

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
        box.erase();
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
